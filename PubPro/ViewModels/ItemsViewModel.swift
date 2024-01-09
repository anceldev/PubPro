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
    
    init() {
        do {
            try fetchDBItems()
        }
        catch {
            print("Cannot initialize Items from constructor")
        }
    }
    private func fetchDBItems() throws{
        Task {
            do {
                self.drinks = try await Repositories.fetchDrinks()
                self.rewards = try await Repositories.fetchRewards()
            }
            catch {
                print("[ItemsViewModel] Cannot fetch items")
            }
        }
    }
}

