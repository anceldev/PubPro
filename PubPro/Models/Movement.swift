 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation

struct Movement: Codable, Identifiable{
    var id: UUID
    var drink: String
    var points: Int
    var date: Date
    
    init(drink: String = "", points: Int = 0, date: Date = .now) {
//        self.drinkID = drinkID
        self.id = UUID()
        self.drink = drink
        self.points = points
        self.date = date
        
    }
}

extension Movement {
    static let empty = Movement()
}
