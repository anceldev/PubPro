//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

protocol Item {
    var id: UUID { get}
    var name: String { get set }
    var descriptionItem: String { get set }
    var value: Int { get set }
    var lastUpdate: Date { get set }
}


//@Model
class Drink: Item {
//    @Attribute(.unique) var id: String
    var id: UUID
    var name: String
    var descriptionItem: String
    var value: Int
    var lastUpdate: Date

    
    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
        self.lastUpdate = lastUpdate
    }
}

//@Model
class Reward: Item {
//    @Attribute(.unique) var id: String
    var id: UUID
    var name: String
    var descriptionItem: String
    var value: Int
    var lastUpdate: Date
    
    var nameIcon: String {
        name + "-100"
    }
    
    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
        self.lastUpdate = lastUpdate
    }
}
