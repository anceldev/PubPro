//
//  SignUpView.swift
//  PubPro
//
//  Created by Ancel Dev account on 16/8/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(PubProViewModel.self) private var viewModel
    @Environment(NavigationState.self) private var navState
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        @Bindable var navState = navState
        VStack {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            SecureField("Password", text: $password)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button(action: {
                print("Login action...")
                
            }, label: {
                Text("Sign up")
            })
            .buttonStyle(.borderedProminent)
            Button {
                navState.routes.append(.signIn)
            } label: {
                Text("login")
            }
        }
        .padding(24)
        .navigationTitle("Sign Up")
        .navigationBarBackButtonHidden()
        .sheet(item: $navState.errorWrapper) { errorWrapper in
            VStack {
                Text(errorWrapper.error.localizedDescription)
                Text(errorWrapper.guidance)
                Button {
                    navState.errorWrapper = nil
                    Task {
                        await signUp()
                    }
                } label: {
                    Text("Try again")
                }
            }
            .presentationDetents([.fraction(0.25)])
        }
    }
    private func signUp() async {
        do {
            let signUpResponseDTO = try await viewModel.signUp(username: username, email: email, password: password)
            if !signUpResponseDTO.error {
                username = ""
                email = ""
                password = ""
                navState.routes.append(.signIn)
            } else {
                navState.errorWrapper = ErrorWrapper(error: PubProError.signUp, guidance: "Try again.")
            }
        } catch {
            print(error.localizedDescription)
            navState.errorWrapper = ErrorWrapper(error: error, guidance: "Check your internet connection.")
        }
    }
}

struct SignUpPreviewContainer: View {
    @State private var viewModel = PubProViewModel()
    @State private var navState = NavigationState()
    var body: some View {
        NavigationStack(path: $navState.routes) {
            SignUpView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView()
                    case .signIn:
                        SignInView()
                    case .pubItemsList:
                        PubItemsView()
                    case .profile:
                        ProfileView()
                    case .main:
                        MainTabView()
                    }
                }
        }
        .environment(viewModel)
        .environment(navState)
    }
}

#Preview {
    SignUpPreviewContainer()
}
