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
//    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    @State var userViewModel = UserViewModel()
//    @State var itemsViewModel = ItemsViewModel()
//    @State var user: User?
//    
//    init() {
//        print(authViewModel.isNewUser)
//        if authViewModel.isNewUser {
//            if let user = authViewModel.user {
//                self.user = User(
//                    uid: user.uid,
//                    name: user.displayName ?? "Username",
//                    email: authViewModel.email
//                )
//                modelContext.insert(self.user!)
//            } else { self.user = nil }
//        } else {
//            Task {
//                let user = try await Repositories.fetchUser(id: authViewModel.user!.uid)
//            }
//        }
//    }
    
    var body: some View {
        TabView {
//            if userViewModel.user.role == .admin {
//                ScannerView(drinks: itemsViewModel.drinks, rewards: itemsViewModel.rewards)
//                    .mainTabView("Scanner", systemImage: "qrcode.viewfinder")
//                    .environment(itemsViewModel)
//                    .environment(userViewModel)
//            }
//            else {
//                Profile()
//                    .mainTabView("Profile", systemImage: "person")
//                    .environment(itemsViewModel)
//                    .environment(userViewModel)
//
//                HistoryView()
//                    .mainTabView("History", systemImage: "list.bullet")
//                    .environment(itemsViewModel)
//                    .environment(userViewModel)
//            }
//            DrinksList(drinks: itemsViewModel.drinks)
//                .mainTabView("Drinks", systemImage: "wineglass")
//            
//            RewardsList(rewards: itemsViewModel.rewards)
//                .mainTabView("Rewards", systemImage: "gift.fill")
//            
//            SettingsView(userViewModel: $userViewModel)
//                .mainTabView("Settings", systemImage: "gear")
//            
        }
        .tint(.beerOrange)
    }
}
#Preview {
    MainView()
}
