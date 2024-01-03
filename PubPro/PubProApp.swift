//
//  PubProApp.swift
//  PubPro
//
//  Created by Ancel Dev account on 26/11/23.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        /// Authentication emulator settings
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        
        /// Firestore emulator settings
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        return true
    }
}

@main
struct PubProApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AuthenticatedView()
            }
        }
        .environmentObject(AuthenticationViewModel())
    }
}
