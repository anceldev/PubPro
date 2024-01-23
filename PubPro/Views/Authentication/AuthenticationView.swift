//
//  AuthenticationView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.flow {
            case .login:
                SignInView()
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
        .environmentObject(AuthenticationViewModel())
}
#Preview {
    let authViewModel = AuthenticationViewModel()
    authViewModel.flow = .signUp
    return AuthenticationView()
        .environmentObject(authViewModel)
}
#Preview {
    let authViewModel = AuthenticationViewModel()
    authViewModel.flow = .recoveryPassword
    return AuthenticationView()
        .environmentObject(authViewModel)
}
