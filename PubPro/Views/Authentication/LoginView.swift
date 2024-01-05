//
//  LoginView.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI
import SwiftData
// For Sign-In with Apple
import AuthenticationServices

struct LoginView: View {
    
//    @Environment(AuthenticationViewModel.self) var authViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("Login")
                .font(.largeTitle)
            TextField("Email", text: $email, prompt: Text("Email"))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password, prompt: Text("Password"))
                .autocorrectionDisabled()
            VStack{
                Button(action: signInWithEmailPassword) {
                    Text("Log-In")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .foregroundStyle(.ownDarkGray).bold()
                }
                Button(action: signInWithGoogle) {
                    Text("Sign In with Google")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(alignment: .leading) {
                            Image("Google")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                        .foregroundStyle(.ownDarkGray).bold()
                }
                SignInWithAppleButton { request in
                    authViewModel.handleSignInWithApppleRequest(request)
                } onCompletion: { result in
                    authViewModel.handleSignInWithAppleCompletion(result)
                }
                .signInWithAppleButtonStyle(.black)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .cornerRadius(8)

            }
            .buttonStyle(.bordered)
            
            Button("Sign up") {
                withAnimation {
                    authViewModel.flow = .signUp
                }
            }
            .padding(.top, 8)
            Spacer()
            Button("Forgot password?") {
                withAnimation {
                    authViewModel.flow = .recoveryPassword
                }
            }
            Spacer()
        }
        .padding(20)
    }
    /// Sign-In with Email-Password
    func signInWithEmailPassword() {
        authViewModel.email = email
        authViewModel.password = password
        Task {
            if await authViewModel.signInWithEmailPassword() == true {
                print("Authenticated in view")
                dismiss()
            }
            
        }
    }
    /// Sign-In with Google
    func signInWithGoogle(){
        Task {
            if await authViewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationViewModel())
}
