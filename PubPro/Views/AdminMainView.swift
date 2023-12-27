//
//  AdminMainView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct AdminMainView: View {
    @State private var showScanner = false
    var body: some View {
        TabView {
            Profile()
                .tabItem { Label("Profile", systemImage: "person.fill") }
            DrinksList()
                .tabItem { Label("Drinkls", systemImage: "wineglass") }
            RewardsList()
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
        }
    }
}

#Preview {
    AdminMainView()
        .environment(AuthenticationViewModel())
}
