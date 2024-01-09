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
            let user = try await docReference.collection("users_v1.1").document(id).getDocument(as: User.self)
            return user
        }
        catch {
            print("Error fetching user document")
            return User.empty
        }
    }
    /**
     Add a new movement to a user document.
     */
    static func addMovement(for item: Item, with uid: String) async throws -> Bool {
        do {
            let user = try await docReference.collection("users_v1.1").document(uid).getDocument(as: User.self)
            var movements = user.movements
            let newMovement = Movement(itemID: item.id)
            movements.append(newMovement)
            movements.sort { $0.date > $1.date }
            print(movements)
            
            let newMovementObject = [
                "
            ]
            
            let userDocReference = docReference.collection("users_v1.1").document(uid)
            do {
                try await userDocReference.updateData(["movements": movements])
            }
            catch {
                print("Cannot update movements field in user doc. \(error.localizedDescription)")
                throw error
            }
        }
        catch {
            print("Error adding new movement")
            return false
        }
        return true
    }
    /**
     Fetch drinks from database
     */
    static func fetchDrinks() async throws -> [Drink] {
        let documentsSnapshot = try await docReference.collection("drinksDataBase").getDocuments()
        return documentsSnapshot.documents.compactMap { document in
            try! document.data(as: Drink.self)
        }
    }
    /**
     Fetch rewards from databas
     */
    static func fetchRewards() async throws -> [Reward] {
        let documentsSnapshot = try await docReference.collection("rewardsDataBase").getDocuments()
        return documentsSnapshot.documents.compactMap { document in
            try! document.data(as: Reward.self)
        }
    }
    static func updateItemsDB<T:Item>(for items: [T], collection: String) -> Bool {
        let ref = docReference.collection(collection)
        for item in items {
            let itemDocReference = ref.document(item.id.uuidString)
            do {
                try itemDocReference.setData(from: item)
            }
            catch {
                print("[updateItemsDB()] Cannot update Firestore DB for \(collection) collection")
                return false
            }
        }
        return true
    }
}
