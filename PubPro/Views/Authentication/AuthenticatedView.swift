//
//  AuthenticatedView.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import SwiftUI

struct AuthenticatedView: View {
    
//    @State var authVM = AuthenticationViewModel()
//    @Environment(AuthenticationViewModel.self) var viewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var loginScreen = false
    
    var body: some View {
        VStack{
            switch viewModel.authenticationState {
            case .unauthenticated:
                VStack {
                    Spacer()
                    VStack {
                        
                        VStack(alignment: .center) {
                            Text("PubPro")
                                .font(.custom("Styleturn", size: 80))
                                .padding(.bottom, 70)
                                .foregroundStyle(.beerOrange)
                                .foregroundStyle(.green)
                            Text("Welcome to PubPro, the app where you can accumulate points in your favourte pub and access to incredible rewards")
                                .font(.custom("RobotoCondensed-Light", size: 25))
                                .lineSpacing(8)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.ppDarkWhite)
                            Button("Login") {
                                loginScreen.toggle()
                            }
                            .foregroundStyle(.beerYellow)
                            .padding(.top, 20)
                        }
                        .padding(30)
                    }
                   Spacer()
                }
            case .authenticating:
                ProgressView()
            case .authenticated:
                MainView()
//                    .environment(authVM)
            }
        }
        .onAppear {
            print("Appear")
            print(viewModel.authenticationState)
        }
        .background(.ppDark)
        .sheet(isPresented: $loginScreen) {
            AuthenticationView()
//                .environment(authVM)
        }
    }
}

#Preview {
    AuthenticatedView()
        .environmentObject(AuthenticationViewModel())
}
