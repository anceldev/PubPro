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
    
    private var listenerRegistration: ListenerRegistration?
    
    init(){
        registerAuthStateHandler()
    }
    
    func suscribe() {
        guard let docID = user.id else { return }
        let ref = Firestore.firestore().collection("users_v1.1").document(docID)
        
        if listenerRegistration == nil {
            listenerRegistration = ref.addSnapshotListener({ snapshotDoc, error in
                guard snapshotDoc != nil else { return }
                do {
                    if let document = try snapshotDoc?.data(as: User.self){
                        self.user = document
                    }
                    else {
                        print("Cannot decode document in User type")
                    }
                }
                catch {
                    print("Error listening document")
                }
            })
        }
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
            }
            catch {
                fatalError("getUser() function can get user from Repositories.fetchUser")
            }
        }
    }
}
