//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

protocol Item: Codable{
    var id: UUID { get}
    var name: String { get set }
    var descriptionItem: String { get set }
    var value: Int { get set }
    var lastUpdate: Date { get set }
    var image: String { get }
}


//@Model
//class Drink: Item, Codable {
////    @Attribute(.unique) var id: String
//    var id: UUID
//    var name: String
//    var descriptionItem: String
//    var value: Int
//    var lastUpdate: Date
//    
//    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
//        self.id = id
//        self.name = name
//        self.descriptionItem = descriptionItem
//        self.value = value
//        self.lastUpdate = lastUpdate
//    }
//}
struct Drink: Item, Codable {
    var id: UUID
    var name: String
    var descriptionItem: String
    var value: Int
    var lastUpdate: Date
    
    var image: String {
        name.removingAccents.lowercased() + "-100"
    }
    
    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
        self.lastUpdate = lastUpdate
    }
}
struct Reward: Item, Codable {
    var id: UUID
    var name: String
    var descriptionItem: String
    var value: Int
    var lastUpdate: Date
    
    var image: String {
        name.removingAccents.lowercased() + "-100"
    }
    
    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
        self.lastUpdate = lastUpdate
    }
}
extension Drink {
    static let drinks = [
        Drink(name: "Cóctel", descriptionItem: "Description and ingredient, ingredient, etc", value: 50),
        Drink(name: "Cachimba", descriptionItem: "Drescription and ingredient types of it", value: 80),
        Drink(name: "Cubata", descriptionItem: "Description of item", value: 40)
    ]
}
extension Reward {
    static let rewards = [
        Reward(name: "Cóctel", descriptionItem: "Description and ingredient, ingredient, etc", value: 350),
        Reward(name: "Cachimba", descriptionItem: "Drescription and ingredient types of it", value: 450),
        Reward(name: "Cubata", descriptionItem: "Description of item", value: 310)
    ]
}

extension String {
    var removingAccents: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}


//@Model
//class Reward: Item, Codable {
////    @Attribute(.unique) var id: String
//    var id: UUID
//    var name: String
//    var descriptionItem: String
//    var value: Int
//    var lastUpdate: Date
//    
//    var nameIcon: String {
//        name + "-100"
//    }
//    
//    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
//        self.id = id
//        self.name = name
//        self.descriptionItem = descriptionItem
//        self.value = value
//        self.lastUpdate = lastUpdate
//    }
//}
