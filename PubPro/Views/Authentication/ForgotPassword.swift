//
//  RecoverPassword.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI

struct ForgotPassword: View {
//    @Environment(AuthenticationViewModel.self) var authViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Spacer()
                VStack {
                    Text("Recover")
                        .font(.custom("RobotoCondensed-Regular", size: 50))
                    Text("Password")
                        .font(.custom("RobotoCondensed-Regular", size: 35))
                }
                .foregroundStyle(.beerOrange)
                Spacer()
                TextField("Email", text: $email, prompt: Text("Email"))
                    .ownTfStyle()
                    .padding(.bottom, 8)
                
                Button(action: {
                    if !email.isEmpty {
                        resetPassword()
                    }
                }, label: {
                    Text("Send email")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .foregroundStyle(.ownDarkGray).bold()
                })
                .ownButtonStyle()
                Spacer()
                Spacer()
                Button("Cancel") {
                    withAnimation {
                        authViewModel.flow = .login
                    }
                }
                .foregroundStyle(.beerYellow)
                .padding(.top, 30)
            }
            .padding(20)
        }
        .background(.ppDark)
    }
    func resetPassword() {
        Task {
            do {
                let emailSended = try await authViewModel.sendResetPasswordEmail(for: email)
                    if emailSended == true {
                        print("Email sended")
                        dismiss()
                    }
                    else {
                        print("Cant send Email now")
                    }
            }
        }
        print("Call to recover password function.")
//        dismiss()
    }
}

#Preview {
    ForgotPassword()
        .environmentObject(AuthenticationViewModel())
}
