//
//  PubProApp.swift
//  PubPro
//
//  Created by Ancel Dev account on 16/8/24.
//

import SwiftUI
import OSLog

let logger = Logger()

@main
struct PubProApp: App {
    
    @State private var navState = NavigationState()
    @State private var pubProVM = PubProViewModel()
    
    var body: some Scene {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        WindowGroup {
            NavigationStack(path: $navState.routes) {
                Group {
                    if token == nil || defaults.userId == nil {
                        SignUpView()
                    } else {
                        MainTabView()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView()
                    case .signIn:
                        SignInView()
                    case .pubItemsList:
                        PubItemsView()
                    case .profile:
                        ProfileView()
                    case .main:
                        MainTabView()
                    }
                }
            }
            .environment(navState)
            .environment(pubProVM)
        }
    }
}
