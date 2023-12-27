//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

//@Model
//class Drinks {
//    @Relationship(deleteRule: .cascade) var drinks = [Drink]()
//    init(drinks: [Drink] = [Drink]()) {
//        self.drinks = drinks
//    }
//}

@Model
class Drink {
    var id: Int
    var name: String
    var descriptionDrink: String
    var value: Int
    var lastUpdate: Date

    
    init(id: Int, name: String, descriptionDrink: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionDrink = descriptionDrink
        self.value = value
        self.lastUpdate = lastUpdate
    }
    
}
//    var nameIcon: String {
//        name + "-100"
//    }

//extension Drink {
//    static var testDrinks = [
//        Drink(id: 1, name: "coctel", descriptionDrink: "Descripción de cóctel", value: 100),
//        Drink(id: 2, name: "cachimba", descriptionDrink: "Descripción de cachimba", value: 100),
//        Drink(id: 3, name: "combinado", descriptionDrink: "Descripción de combinado", value: 50)
//    ]
//}
