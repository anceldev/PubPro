//
//  LoginView.swift
//  PubPro
//
//  Created by Ancel Dev account on 16/8/24.
//

import Foundation
import SwiftUI

struct SignInView: View {
    
    @Environment(PubProViewModel.self) private var viewModel
    @Environment(NavigationState.self) private var navState
    
    @State var username = ""
    @State var password = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWithespace && !password.isEmptyOrWithespace
    }
    
    var body: some View {
        @Bindable var navState = navState
        VStack {
            TextField("Name", text: $username)
                .textInputAutocapitalization(.never)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            SecureField("Password", text: $password)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button(action: {
                Task {
                    await signIn()
                }
            }, label: {
                Text("Login")
            })
            .buttonStyle(.borderedProminent)
            Button(action: {
                navState.routes.append(.signUp)
            }, label: {
                Text("Sign Up")
            })
        }
        .padding(24)
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden()
        .sheet(item: $navState.errorWrapper) { errorWrapper in
            VStack {
                Text(errorWrapper.error.localizedDescription)
                Text(errorWrapper.guidance)
                Button {
                    navState.errorWrapper = nil
                    Task {
                        await signIn()
                    }
                } label: {
                    Text("Try again")
                }
            }
            .presentationDetents([.fraction(0.25)])
        }
    }
    private func signIn() async {
        do {
            let signInResponseDTO = try await viewModel.signIn(username: username, password: password)
            if signInResponseDTO.error {
                navState.errorWrapper = ErrorWrapper(error: PubProError.signIn, guidance: signInResponseDTO.reason ?? "")
            } else {
                username = ""
                password = ""
                navState.routes.append(.main)
            }
            
        } catch {
            print(error.localizedDescription)
            navState.errorWrapper = ErrorWrapper(error: error, guidance: "Check your internet connection")
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
            .environment(NavigationState())
            .environment(PubProViewModel())
    }
}
