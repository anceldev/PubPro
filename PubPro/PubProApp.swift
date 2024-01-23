//
//  PubProApp.swift
//  PubPro
//
//  Created by Ancel Dev account on 26/11/23.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import SwiftUI
import SwiftData

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
        
        /// Cloud Storage emulator settings
        Storage.storage().useEmulator(withHost: "127.0.0.1", port: 9199)
        
        return true
    }
}

@main
struct PubProApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                AuthenticatedView()
                ContentView()
            }
        }
        .environmentObject(AuthenticationViewModel())
    }
}
