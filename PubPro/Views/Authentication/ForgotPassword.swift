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
            Spacer()
            Spacer()
            Text("Recover Password")
                .font(.largeTitle)
            Spacer()
            TextField("Email", text: $email, prompt: Text("Email"))
            
            Button(action: recoverPassword, label: {
                Text("Send email")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.ownDarkGray).bold()
            })
            .buttonStyle(.bordered)
            
            Button("Cancel") {
                withAnimation {
                    authViewModel.flow = .login
                }
            }
            .padding(.vertical, 8)
            Spacer()
            Spacer()
        }
        .padding(20)
    }
    func recoverPassword() {
        print("Call to recover password function.")
        dismiss()
    }
}

#Preview {
    ForgotPassword()
        .environmentObject(AuthenticationViewModel())
}
