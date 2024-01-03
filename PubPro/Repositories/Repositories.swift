//
//  Repositories.swift
//  PubPro
//
//  Created by Ancel Dev account on 25/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class Repositories {
    static let docReference = Firestore.firestore()
    
    static func fetchUser(id: String) async throws -> User {
        do {
            let user = try await docReference.collection("users_v1").document(id).getDocument(as: User.self)
            return user
        }
        catch {
            print("Error fetching user document")
            return User.empty
        }
    }
    static func fetchMovements(id: String) async throws -> [Movement] {
//        do {
//            let movements = try await docReference
//                .collection("users_v1").document(id)
//                .collection("movements").getDocuments()
//        }
        return []
    }
    
//    static func fetchUser(id: String) async throws -> User {
//        Task {
//            do {
//                let user = try await users.document(id).getDocument(as: User.self)
//                return user
//            }
//            catch {
//                fatalError("Cant fetch user document.")
//            }
//        }
//    }
    
}
