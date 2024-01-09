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
    /**
     Registers AuthStateDidChangeListenerHandle to get current user signed in
     */
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
    /**
     Fetch user data from Firestore document
     */
    func getUser() {
        Task {
            do {
                self.user = try await Repositories.fetchUser(id: self.user.id!)
                print("Your role is: \(self.user.role.rawValue)")
                for movement in user.movements {
                    print(movement)
                }
            }
            catch {
                fatalError("getUser() function can get user from Repositories.fetchUser")
            }
        }
    }
}
