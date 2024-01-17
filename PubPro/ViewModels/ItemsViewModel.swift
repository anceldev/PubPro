//
//  ItemsViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 9/1/24.
//

import Foundation
import Observation

@Observable
class ItemsViewModel {
    var drinks = [Drink]()
    var rewards = [Reward]()
    var itemsList = [UUID]()
    
    init() {
        do {
            try fetchDBItems()
        }
        catch {
            print("Cannot initialize Items from constructor")
        }
    }
    /**
     Checks an returns which type is refered to the itemID
     */
    func getItem(for itemID: UUID) -> Item {
        if let isDrink = drinks.first(where: { $0.id == itemID }) {
            return isDrink
        } else {
            return rewards.first(where: { $0.id == itemID })!
        }
    }
    /**
     Fetch de DB to get the items in Firestore
     */
    private func fetchDBItems() throws{
        Task {
            do {
                self.drinks = try await Repositories.fetchDrinks()
                self.rewards = try await Repositories.fetchRewards()
                self.itemsList = self.drinks.map({ $0.id })
                self.itemsList += self.rewards.map({ $0.id })
            }
            catch {
                print("[ItemsViewModel] Cannot fetch items")
            }
        }
    }
}

