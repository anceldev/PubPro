//
//  AuthenticationViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import Observation
import GoogleSignIn
import GoogleSignInSwift

/// Controls the authentication state
enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

// Controls the authentication flow
enum AuthenticationFlow {
    case login
    case signUp
    case recoveryPassword
}

@Observable
class AuthenticationViewModel {
    var email = ""
    var password = ""
    var confirmPassword = ""
    
    var flow: AuthenticationFlow = .login
    
    var isValid = false
    var authenticationState: AuthenticationState = .unauthenticated
    
    var errorMessage = ""
    var user: User?
    var displayName = ""
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        registerAuthStateHanlder()
    }
    
    /// Handles the auth state
    func registerAuthStateHanlder() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            })
        }
    }
    
    func resetStates() {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
    // MARK: - Email Password Sign-In
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
    
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            try await Auth.auth().createUser(withEmail: self.email, password: self.password)
            authenticationState = .authenticated
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func sigOut() {
        do {
            try Auth.auth().signOut()
            authenticationState = .authenticated
            flow = .login
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}

enum AuthenticationError: Error {
    case tokenError(message: String)
}
extension AuthenticationViewModel {
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
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
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }
}

