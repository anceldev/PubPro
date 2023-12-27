//
//  MainView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct MainView: View {
    @Environment(AuthenticationViewModel.self) var authViewModel
    
    var body: some View {
        TabView {
            Profile()
                .tabItem { Label("Profile", systemImage: "person") }
            HistoryView()
                .tabItem { Label("History", systemImage: "list.bullet") }
            DrinksList()
                .tabItem { Label("Drinks", systemImage: "wineglass") }
            RewardsList()
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    MainView()
        .environment(AuthenticationViewModel())
}
