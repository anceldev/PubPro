//
//  AuthenticatedView.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import SwiftUI

struct AuthenticatedView: View {
    
//    @State var authVM = AuthenticationViewModel()
    @Environment(AuthenticationViewModel.self) var viewModel
    @State private var loginScreen = false
    
    var body: some View {
        VStack{
            switch viewModel.authenticationState {
            case .unauthenticated:
                Spacer()
                Text("PubPro")
                    .font(.largeTitle)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged")
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Button("Login") {
                    loginScreen.toggle()
                }
                Spacer()
                Spacer()
            case .authenticating:
                ProgressView()
            case .authenticated:
                MainView()
//                    .environment(authVM)
            }
        }
        .sheet(isPresented: $loginScreen) {
            AuthenticationView()
//                .environment(authVM)
        }
    }
}

#Preview {
    AuthenticatedView()
        .environment(AuthenticationViewModel())
}
