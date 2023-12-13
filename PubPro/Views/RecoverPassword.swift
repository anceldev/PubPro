//
//  RecoverPassword.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI

struct RecoverPassword: View {
    @State private var email = ""
    var body: some View {
        VStack {
            Text("Recover Password")
                .font(.largeTitle)
            TextField("Email", text: $email, prompt: Text("Email"))
            Button("Send Email", action: recoverPassword)
        }
    }
    func recoverPassword() {
        //
        print("Call to recover password function.")
    }
}

#Preview {
    RecoverPassword()
}
