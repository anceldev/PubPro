//
//  RegisterView.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var alertOn = false
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
            TextField("Email", text: $email, prompt: Text("Email"))
            TextField("Password", text: $password, prompt: Text("Password"))
            TextField("Confirm Password", text: $confirmPassword, prompt: Text("Confirm Password"))
            Button("Register", action: register)
        }
        .padding(20)
//        .alert("Wrong password", isPresented: $alertOn) {
//            Text("Your password must match")
//        }
        .alert("Wrong password", isPresented: $alertOn) {
            Text("Try again")
        } message: {
            Text("Your passwords must match")
        }

    }
    func register() {
        if password == confirmPassword {
            //
            print("Call to register function")
        }
        else {
            alertOn = true
        }
    }
}

#Preview {
    RegisterView()
}
