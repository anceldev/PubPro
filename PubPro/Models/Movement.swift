 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData

@Model
class Movement: Codable {
    var date: Date
    var item: Item
    var user: User?
    
    init(date: Date = .now, item: Item, user: User? = nil) {
        self.date = date
        self.item = item
        self.user = user
    }
    
    enum CodingKeys: CodingKey {
//        case date, item, user
        case date, item
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.item = try container.decode(Item.self, forKey: .item)
//        self.user = try container.decode(User.self, forKey: .user)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(item, forKey: .item)
//        try container.encode(user, forKey: .user)
    }
}
