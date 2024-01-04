//
//  AuthenticationViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Observation
import GoogleSignIn
import GoogleSignInSwift

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
    
    /**
     Constructor.
     */
    init() {
        registerAuthStateHanlder()
    }
    /**
     Handles the Authentication State.
     */
    func registerAuthStateHanlder() {
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
extension AuthenticationViewModel {
    /**
     Sign in with GoogleAuthentication SDK
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

