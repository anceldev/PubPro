//
//  SettingsView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "Settings")
            }
            .padding(33)
            Spacer()
            Button("SignOut", action: signOutAccount)
                .foregroundStyle(.red.opacity(0.7))
            Spacer()
        }
    }
    private func signOutAccount() {
        authViewModel.signOut()
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationViewModel())
}
