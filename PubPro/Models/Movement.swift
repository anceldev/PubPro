 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData

@Model
class Movement {
    @Attribute(.unique) var id: UUID
    var drinkID: Int
    var points: Int
    var date: Date
    
    
    init(drinkID: Int, points: Int, date: Date) {
        self.drinkID = drinkID
        self.points = points
        self.date = date
        self.id = UUID()
    }
}
