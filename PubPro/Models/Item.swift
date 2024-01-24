//
//  Drink.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

@Model
class Item: Codable {
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
    
    enum CodingKeys: CodingKey {
//        case name, descriptionItem, value, kind, movements
        case name, descriptionItem, value, kind
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.descriptionItem = try container.decode(String.self, forKey: .descriptionItem)
        self.value = try container.decode(Int.self, forKey: .value)
        self.kind = try container.decode(Kind.self, forKey: .kind)
//        self.movements = try container.decode([Movement].self, forKey: .movements)
        self.movements = []
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(descriptionItem, forKey: .descriptionItem)
        try container.encode(value, forKey: .value)
        try container.encode(kind, forKey: .kind)
//        try container.encode(movements, forKey: .movements)
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
