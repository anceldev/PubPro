//
//  AuthenticationViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
// Firebase SDK
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
// Sign in with Google
import GoogleSignIn
import GoogleSignInSwift
// Sign in with Apple
import AuthenticationServices
import CryptoKit
/**
 Controls the authentication state
 */
enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

/**
 Controls the authentication flow
 */
enum AuthenticationFlow {
    case login
    case signUp
    case recoveryPassword
}

@MainActor
final class AuthenticationViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var flow: AuthenticationFlow = .login

    @Published var isValid = false
    @Published var authenticationState: AuthenticationState = .unauthenticated

    @Published var errorMessage = ""
    @Published var user: FirebaseAuth.User?
    @Published var displayName = ""
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    private var currentNonce: String?
    
    /**
     Constructor.
     */
    init() {
        registerAuthStateHandler()
//        verifySignInWithAppleAuthenticationState()
    }
    /**
     Handles the Authentication State.
     */
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            })
        }
    }
    /**
     Resets flow state and email, password and confirmPassword variables.
     */
    func resetStates() {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
    /**
     Sign in with Email and Password
     */
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        print(self.email)
        print(self.password)
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            authenticationState = .authenticated
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    /**
     Sign up with Email and Password
     */
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            try await Auth.auth().createUser(withEmail: self.email, password: self.password)
            authenticationState = .authenticated
            createUserDocument(email: email)
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    /**
     Sign out user account
     */
    func signOut() {
        do {
            try Auth.auth().signOut()
            authenticationState = .authenticated
            flow = .login
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            fatalError("Can't sign out")
        }
    }
}

enum AuthenticationError: Error {
    case tokenError(message: String)
}
// MARK: Sign In With Google
extension AuthenticationViewModel {
    /**
     Sign-In with Google using GoogleAuthentication SDK
     */
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
        //              let window = await windowScene.windows.first,
        //              let rootViewController = await window.rootViewController else {
        //            print("There is no root view controller")
        //            return false
        //        }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            authenticationState = .authenticated
            
            createUserDocument(email: userAuthentication.user.profile!.email)
            
            print("User is: \(firebaseUser.uid)")
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }
}

// MARK: Sign In with Apple
extension AuthenticationViewModel {
    /**
     Sign-In with Apple
     */
    func handleSignInWithApppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        if case .failure(let failure) = result {
            errorMessage = failure.localizedDescription
        }
        else if case .success(let authorization) = result {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: a login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identify token")
                    return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                          idToken: idTokenString,
                                                          rawNonce: nonce)
                Task {
                    do {
                        let result = try await Auth.auth().signIn(with: credential)
                        createUserDocument(email: result.user.email!)
                        authenticationState = .authenticated
                    }
                    catch {
                        print("Error authenticating: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    /**
     Verify authentication state for signInWithApple authenticaiton
     */
    func verifySignInWithAppleAuthenticationState() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let providerData = Auth.auth().currentUser?.providerData
        if let appleProviderData = providerData?.first(where: { $0.providerID == "apple.com" }) {
            Task {
                do {
                    let credentialState = try await appleIDProvider.credentialState(forUserID: appleProviderData.uid)
                    switch credentialState {
                    case .authorized:
                        break
                    case .revoked, .notFound:
                        self.signOut()
                    default:
                        break
                    }
                }
                catch {
                    print("Verify authentication state with apple error: \(error.localizedDescription)")
                }
            }
        }
    }
}
extension AuthenticationViewModel {
    /**
     Creates new User document in Firestore database
     */
    func createUserDocument(email: String) {
        let newUser = User(email: email, role: .user, movements: [Movement(drink: "Welcome gift", points: 60, date: .now)])
        guard let documentId = user?.uid else { return }
        let documentRef = Firestore.firestore().collection("users_v1").document(documentId)
        
        documentRef.getDocument { document, error in
            if let document = document, document.exists {
                print("Document exists")
            }
            else {
                do {
                    try documentRef.setData(from: newUser)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension AuthenticationViewModel {
    /**
     Random nonce string generator function
     */
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0) // Test the condition to make progress
      let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    /**
     SHA256 function
     */
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
