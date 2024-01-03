//
//  MainView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
//    @Environment(AuthenticationViewModel.self) var viewModel

    var viewModel = UserViewModel()
    
    var body: some View {
        TabView {
            if viewModel.user.role == .admin {
                ScannerView()
                    .tabItem { Label("Scanner", systemImage: "qrcode.viewfinder") }
            }
            else {
                Profile(user: viewModel.user)
                    .tabItem { Label("Profile", systemImage: "person") }
    //                .environment(authVM)
                HistoryView()
                    .tabItem { Label("History", systemImage: "list.bullet") }
            }
            DrinksList()
                .tabItem { Label("Drinks", systemImage: "wineglass") }
            RewardsList()
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
            if viewModel.user.role == .user {
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
        }
        .tint(.beerOrange)
    }
}

#Preview {
    MainView()
        .environmentObject(AuthenticationViewModel())
}
