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
    
    @State var userViewModel = UserViewModel()
    @State var itemsViewModel = ItemsViewModel()
    
    var body: some View {
        TabView {
            if userViewModel.user.role == .admin {
                ScannerView(drinks: itemsViewModel.drinks, rewards: itemsViewModel.rewards)
                    .tabItem { Label("Scanner", systemImage: "qrcode.viewfinder") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.ppDark, for: .tabBar)
                    .environment(itemsViewModel)
                    .environment(userViewModel)
            }
            else {
                Profile()
                    .tabItem { Label("Profile", systemImage: "person") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.ppDark, for: .tabBar)
                    .environment(itemsViewModel)
                    .environment(userViewModel)

                HistoryView()
                    .tabItem { Label("History", systemImage: "list.bullet") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.ppDark, for: .tabBar)
                    .environment(itemsViewModel)
                    .environment(userViewModel)
            }
            DrinksList(drinks: itemsViewModel.drinks)
                .tabItem { Label("Drinks", systemImage: "wineglass") }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.ppDark, for: .tabBar)
            
            RewardsList(rewards: itemsViewModel.rewards)
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.ppDark, for: .tabBar)
            
            SettingsView(userViewModel: $userViewModel)
                .tabItem { Label("Settings", systemImage: "gear") }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.ppDark, for: .tabBar)
            
        }
        .tint(.beerOrange)
    }
}
#Preview {
//    let userViewModel = UserViewModel()
//    userViewModel.user.role = .user
//    return MainView()
    MainView()
}
