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

struct SignInView: View {
    
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
            VStack {
                Spacer()
//                Spacer()
                
                Text("Sign In")
                    .font(.custom("RobotoCondensed-Regular", size: 50))
                    .foregroundStyle(.beerOrange)
                Spacer()

                TextField("Email", text: $email, prompt: Text("Email"))
                        .ownTfStyle()
                        .padding(.bottom, 8)
                    SecureField("Password", text: $password, prompt: Text("Password"))
                        .ownTfStyle()
                        .padding(.bottom, 30)
                VStack{
                    Button(action: signInWithEmailPassword) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .foregroundStyle(.ownDarkGray).bold()
                    }
                    .tint(.white)
                    .buttonStyle(.borderedProminent)
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
                    .tint(.white)
                    .buttonStyle(.borderedProminent)
                    SignInWithAppleButton { request in
                        authViewModel.handleSignInWithApppleRequest(request)
                    } onCompletion: { result in
                        authViewModel.handleSignInWithAppleCompletion(result)
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(maxWidth: .infinity, maxHeight: 52)
                    .cornerRadius(10)
                    
                }
                
                
                VStack {
                    Text("Don't have account?")
                        .foregroundStyle(.ppDarkWhite)
                    Button("Sign up") {
                        withAnimation {
                            authViewModel.flow = .signUp
                        }
                    }
                    .foregroundStyle(.beerYellow)
                }
                .padding(.top, 8)
                Spacer()
                Button("Forgot password?") {
                    withAnimation {
                        authViewModel.flow = .recoveryPassword
                    }
                }
                .foregroundStyle(.beerYellow)
            }
            Spacer()
        }
        .padding(20)
        .background(.ppDark)
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
    SignInView()
        .environmentObject(AuthenticationViewModel())
}
