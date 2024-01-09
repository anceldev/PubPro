//
//  SettingsView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Binding var userViewModel: UserViewModel
    @State var userName: String = ""
    @State private var confirmChanges = false
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    TitleView(title: "Settings")
                }
                .padding(33)
                Spacer()
                
                VStack {
                    Text("Update your profile data:")
                    TextField("Username", text: $userName)
                }
                .padding(.horizontal, 15)
                Spacer()
                Button("Update", action: updateProfileData)
                    .buttonStyle(.borderedProminent)
                    .confirmationDialog("Change profile", isPresented: $confirmChanges, actions: {
                        Button("Ok") {
                            print("Ok to confirmation dialog")
                            confirmChanges = false
                            userName = ""
                        }
                    }, message: {
                        Text("Your name has been updated")
                    })
                Spacer()
                Button("SignOut", action: signOutAccount)
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .background(.ppDarkWhite)
    }
    private func signOutAccount() {
        authViewModel.signOut()
    }
    private func updateDrinksDB() {
        
    }
    private func updateProfileData() {
        self.confirmChanges = authViewModel.userProfileChangeRequest(username: userName)
        userViewModel.user.name = userName // Update name locally for this sesion
    }
}

#Preview {
    @State var userViewModel = UserViewModel()
    return SettingsView(userViewModel: $userViewModel)
        .environmentObject(AuthenticationViewModel())
}
