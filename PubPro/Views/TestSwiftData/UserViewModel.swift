//
//  UserViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 17/1/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class UsViewModel {
    let container = try! ModelContainer(for: User.self, Movement.self, Item.self)
    var user: User?
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    @MainActor
    func fechUser() {
        let fetchDescriptor = FetchDescriptor<User>(predicate: nil)
        do {
            self.user = try modelContext.fetch(fetchDescriptor).first
        }
        catch {
            fatalError("Model can't be fetch")
        }
    }
    @MainActor
    func insertModel(user: User) {
        self.modelContext.insert(user)
        self.user = nil
        fechUser()
    }
}
