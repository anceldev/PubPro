//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

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
