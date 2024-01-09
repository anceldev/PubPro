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
    
    @State var viewModel = UserViewModel()
    //    @State var viewModel: UserViewModel
    
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
                HistoryView(movements: viewModel.user.movements)
                    .tabItem { Label("History", systemImage: "list.bullet") }
            }
            DrinksList()
                .tabItem { Label("Drinks", systemImage: "wineglass") }
            RewardsList()
                .tabItem { Label("Rewards", systemImage: "gift.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
                .toolbarBackground(Color.ppDark)
            
        }
        .tint(.beerOrange)
        
    }
}
#Preview {
    let userViewModel = UserViewModel()
    userViewModel.user.role = .user
    return MainView(viewModel: userViewModel)
}
#Preview {
    let adminViewModel = UserViewModel()
    adminViewModel.user.role = .admin
    return MainView(viewModel: adminViewModel)
}
