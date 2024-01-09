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
    static func fetchDrinks() async throws -> [Drink] {
        let documentsSnapshot = try await docReference.collection("drinks").getDocuments()
        return documentsSnapshot.documents.compactMap { document in
            try! document.data(as: Drink.self)
        }
    }
    static func fetchRewards() async throws -> [Reward] {
        let documentsSnapshot = try await docReference.collection("drinks").getDocuments()
        return documentsSnapshot.documents.compactMap { document in
            try! document.data(as: Reward.self)
        }
    }
//    static func updateDrinks() -> Bool{
//        let ref = docReference.collection("drinksDataBase")
//        for drink in Drink.drinks {
//            let drinkDocReference = ref.document(drink.id.uuidString)
//            do {
//                try drinkDocReference.setData(from: drink)
//            }
//            catch {
//                print(["[updateDrinks] Cannot write to drinks DB"])
//                return false
//            }
//        }
//        return true
//    }
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
