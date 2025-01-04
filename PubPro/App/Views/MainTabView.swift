//
//  MainTabView.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct MainTabView: View {
    enum TabViewItem {
        case home
        case history
        case pubitems
        case profile
    }
    
    @State private var selectedTab: TabViewItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(user: User.preview)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(TabViewItem.home)
            HistoryView()
                .tag(TabViewItem.history)
                .tabItem {
                    Image(systemName: "clock")
                }
            PubItemsView()
                .tag(TabViewItem.history)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            ProfileView()
                .tag(TabViewItem.profile)
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .animation(.easeIn, value: selectedTab)
    }
}

#Preview {
    MainTabView()
        .environment(PubProViewModel())
        .environment(NavigationState())
}
