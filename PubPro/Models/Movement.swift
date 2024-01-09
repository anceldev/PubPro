 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation

struct Movement: Codable, Identifiable{
    var id: UUID
    var itemID: UUID
    var date: Date
    
    init(id: UUID = UUID(), itemID: UUID, date: Date = .now) {
        self.id = id
        self.itemID = itemID
        self.date = date
    }
}

extension Movement {
//    static let empty = Movement()
}
