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
                    .mainTabView("Scanner", systemImage: "qrcode.viewfinder")
                    .environment(itemsViewModel)
                    .environment(userViewModel)
            }
            else {
                Profile()
                    .mainTabView("Profile", systemImage: "person")
                    .environment(itemsViewModel)
                    .environment(userViewModel)

                HistoryView()
                    .mainTabView("History", systemImage: "list.bullet")
                    .environment(itemsViewModel)
                    .environment(userViewModel)
            }
            DrinksList(drinks: itemsViewModel.drinks)
                .mainTabView("Drinks", systemImage: "wineglass")
            
            RewardsList(rewards: itemsViewModel.rewards)
                .mainTabView("Rewards", systemImage: "gift.fill")
            
            SettingsView(userViewModel: $userViewModel)
                .mainTabView("Settings", systemImage: "gear")
            
        }
        .tint(.beerOrange)
    }
}
#Preview {
    MainView()
}
