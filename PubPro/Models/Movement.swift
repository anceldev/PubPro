 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation

struct Movement: Codable{
    var id: UUID
    var drinkID: Int
    var points: Int
    var date: Date
    
    init(drinkID: Int = 0, points: Int = 0, date: Date = .now) {
        self.drinkID = drinkID
        self.points = points
        self.date = date
        self.id = UUID()
    }
}

extension Movement {
    static let empty = Movement()
}
