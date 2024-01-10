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
                    .environment(itemsViewModel)
            }
            else {
                Profile()
                    .tabItem { Label("Profile", systemImage: "person") }
                    .environment(userViewModel)
                //                .environment(authVM)
                HistoryView()
                    .environment(itemsViewModel)
                    .environment(userViewModel)
                    .tabItem { Label("History", systemImage: "list.bullet") }
            }
            DrinksList(drinks: itemsViewModel.drinks)
                .tabItem { Label("Drinks", systemImage: "wineglass") }
            RewardsList(rewards: itemsViewModel.rewards)
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
            SettingsView(userViewModel: $userViewModel)
                .tabItem { Label("Settings", systemImage: "gear") }
                .toolbarBackground(Color.ppDark)
            
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
#Preview {
//    let adminViewModel = UserViewModel()
//    adminViewModel.user.role = .admin
//    return MainView()
    MainView()
}
