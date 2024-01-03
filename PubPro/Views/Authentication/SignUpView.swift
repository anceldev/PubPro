//
//  RegisterView.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    
    @Environment(\.modelContext) var modelContext
//    @Environment(AuthenticationViewModel.self) var authViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var alertOn = false
    
    var body: some View {

        VStack {
            Spacer()
            Spacer()
            Text("Register")
                .font(.largeTitle)
            TextField("Email", text: $email, prompt: Text("Email"))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password, prompt: Text("Password"))
            SecureField("Confirm Password", text: $confirmPassword, prompt: Text("Confirm Password"))
            
            Button(action: signUpWithEmailPassword) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.ownDarkGray).bold()
            }
            .buttonStyle(.bordered)
            Button("Already have account?") {
                withAnimation {
                    authViewModel.flow = .login
                }
            }
            .padding(.vertical, 8)
            Spacer()
            Spacer()
        }
        .padding(20)
        .alert("Wrong password", isPresented: $alertOn) {
            Text("Try again")
        } message: {
            Text("Your passwords must match")
        }

    }
    func signUpWithEmailPassword() {
        if password == confirmPassword {
            authViewModel.email = email
            authViewModel.password = password
            
            Task {
                if await authViewModel.signUpWithEmailPassword() == true {
                    dismiss()
                }
            }
        }
        else {
            alertOn = true
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthenticationViewModel())
}
