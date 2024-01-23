//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

@Model
class Item {
    var name: String
    var descriptionItem: String
    var value: Int
//    var image: String
    var kind: Kind
    @Relationship(inverse: \Movement.item) var movements: [Movement]
    
    init(name: String = "", descriptionItem: String = "", value: Int = 0, image: String = "", kind: Kind = .drink, movements: [Movement] = []) {
        self.name = name
        self.descriptionItem = descriptionItem
        self.value = value
//        self.image = image
        self.kind = kind
        self.movements = movements
    }
}
enum Kind: String, Codable {
    case drink = "Drink"
    case reward = "Reward"
}

/// Extensión used to remove spanish symbols in image name
extension String {
    var removingAccents: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
