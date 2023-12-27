//
//  AuthenticationView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Environment(AuthenticationViewModel.self) var authViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.flow {
            case .login:
                LoginView()
            case .signUp:
                SignUpView()
            case .recoveryPassword:
                ForgotPassword()
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
