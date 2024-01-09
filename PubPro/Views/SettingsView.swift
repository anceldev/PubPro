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
//            Button("Write drinks DB") {
//                if Repositories.updateItemsDB(for: Drink.drinks, collection: "drinksDataBase") {
//                    print("Drinks DB updated")
//                } else {
//                    print("Couldn't update drinks DB")
//                }
//            }
//            Spacer()
//            Button("Write rewards DB") {
//                if Repositories.updateItemsDB(for: Reward.rewards, collection: "rewardsDataBase") {
//                    print("Rewards database upadted")
//                } else {
//                    print("Couldn't update rewards database")
//                }
//            }
            Spacer()
            Button("SignOut", action: signOutAccount)
                .foregroundStyle(.red.opacity(0.7))
            Spacer()
        }
    }
    private func signOutAccount() {
        authViewModel.signOut()
    }
    private func updateDrinksDB() {
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationViewModel())
}
