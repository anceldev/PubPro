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
    static func addMovement(drink: Item, uid: String) async throws -> Bool {
//        let movement = Movement(drink: drink.name, points: drink.value, date: .now)
//        do {
//            let document = docReference.collection("users_v1").document(uid)
//            try await document.updateData([
//                "movements": FieldValue.arrayUnion([movement])
//            ])
//            return true
//        }
//        catch {
//            print("Error in addMovement func.")
//            return false
//        }
        return true
    }
}
