//
//  AuthenticationView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct AuthenticationView: View {
    
//    @Environment(AuthenticationViewModel.self) var authViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.flow {
            case .login:
                LoginView()
//                    .environment(authViewModel)
            case .signUp:
                SignUpView()
//                    .environment(authViewModel)
            case .recoveryPassword:
                ForgotPassword()
//                    .environment(authViewModel)
            }
        }
    }
}

#Preview {
    AuthenticationView()
//        .environment(AuthenticationViewModel())
}
