//
//  UserViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 25/12/23.
//

import Foundation
import SwiftData
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Observation

@Observable
class UserViewModel{
    var user = User.empty
    
    private var userFirestore: FirebaseAuth.User?
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init(){
        registerAuthStateHandler()
    }
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.userFirestore = user
                if let userFirestore = self.userFirestore {
                    self.user.id = userFirestore.uid
                    self.getUser()
                }
            })
        }
        else {
            print("No user registered in authStateHandler")
        }
    }
    
    func getUser() {
        Task {
            do {
                self.user = try await Repositories.fetchUser(id: self.user.id!)
            }
            catch {
                fatalError("getUser() function can get user from Repositories.fetchUser")
            }
        }
    }
}

//@Observable
//final class UserViewModel {
//
//    var user = User.empty
//    
//    private var userFirestore: FirebaseAuth.User?
//    private var db = Firestore.firestore()
//    private var authStateHandler: AuthStateDidChangeListenerHandle?
//    
//    init() {
//        registerAuthStateHandler()
//        print("User view Model is: \(userFirestore?.uid ?? "No user fetched")")
//    }
//
//    func registerAuthStateHandler() {
//        if authStateHandler == nil {
//            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
//                self.userFirestore = user
//                self.fetchUser()
//            })
//        }
//    }
    
//    private func fetchUser() {
//        guard let uid = userFirestore?.uid else { return }
//        Task {
//            do {
//                self.user = try await db.collection("users").document(uid).getDocument(as: User.self)
//            }
//        }
//    }
    
    
//}
