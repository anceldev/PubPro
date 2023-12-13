//
//  LoginView.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
            TextField("Email", text: $email, prompt: Text("Email"))
            TextField("Password", text: $password, prompt: Text("Password"))
            Button("Log in", action: login)
            NavigationLink {
                RegisterView()
            } label: {
                Text("Register")
            }
            NavigationLink {
                RecoverPassword()
            } label: {
                Text("¿Forgotten password?")
            }



        }
        .padding(20)
    }
    func login(){
        print("Login user...")
    }
}

#Preview {
    LoginView()
}
