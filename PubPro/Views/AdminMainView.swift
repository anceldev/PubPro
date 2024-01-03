//
//  AdminMainView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct AdminMainView: View {
//    @Environment(AuthenticationViewModel.self) var authVM
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State private var showScanner = false
    var body: some View {
        TabView {
            Profile(user: User.empty)
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .environmentObject(authVM)
            DrinksList()
                .tabItem { Label("Drinkls", systemImage: "wineglass") }
            RewardsList()
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
        }
    }
}

#Preview {
    AdminMainView()
        .environmentObject(AuthenticationViewModel())
}
