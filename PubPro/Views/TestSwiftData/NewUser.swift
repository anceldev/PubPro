//
//  NewUser.swift
//  PubPro
//
//  Created by Ancel Dev account on 17/1/24.
//

import SwiftUI

struct NewUser: View {
    var viewModel = UsViewModel()
    @State private var name = ""
    @State private var email = ""
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                Button("Save User") {
                    viewModel.insertModel(user: User(name: name, email: email))
                }
            }
        }
    }
}

#Preview {
    NewUser()
}
