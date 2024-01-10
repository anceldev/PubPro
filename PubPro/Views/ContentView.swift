//
//  ContentView.swift
//  PubPro
//
//  Created by Ancel Dev account on 26/11/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Text("First Tab")
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
        .tag(1)
        .toolbarBackground(.hidden, for: .tabBar)

      Text("Second Tab")
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
        .tag(2)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color.orange.opacity(0.8), for: .tabBar)

      Text("Third Tab")
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
        .tag(3)
    }
  }
}

#Preview {
    ContentView()
}
