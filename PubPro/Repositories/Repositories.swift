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
    static func addMovement(for item: Item, with uid: String, itemsList: ItemsViewModel) async throws -> (Bool, String) {
        var outMessage = ""
        do {
            var user = try await docReference.collection("users_v1.1").document(uid).getDocument(as: User.self)
            user.movements.append(Movement(itemID: item.id))
            user.movements.sort { $0.date > $1.date }
            
            if let isDrinkItem = itemsList.drinks.first(where: { $0.id == item.id }) {
                user.points += isDrinkItem.value
                outMessage = "Points added succesfully"
            } else if let isRewardItem = itemsList.rewards.first(where: { $0.id == item.id }) {
                if user.points < isRewardItem.value {
                    outMessage = "User doesn't have enough points for this reward"
                    return (false, outMessage)
                } else {
                    user.points -= isRewardItem.value
                    outMessage = "Reward changed succesfully"
                }
            } else {
                outMessage = "Wrong Item.id reference, couldn't found in Drinks or Rewards database."
                return (false, outMessage)
            }
            // Updates document
            do {
                try docReference.collection("users_v1.1").document(user.id!).setData(from: user)
                print("Document overwritten")
            }
            catch {
                print(error.localizedDescription)
                return (false, outMessage)
            }
        }
        catch {
            print("Error adding new movement")
            return (false, outMessage)
        }
        return (true, outMessage)
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
