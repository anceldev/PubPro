//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

@Model
class Item{
    @Attribute(.unique) var id: UUID
    var name: String
    var descriptionItem: String
    var value: Int
    var typeItem: TypeItem?
    
    init(id: UUID = UUID(), name: String, descriptionItem: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
    }
}
enum TypeItem {
    case drink
    case reward
}
