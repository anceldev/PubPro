 //
//  Movement.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData

@Model
final class Movement {
    @Attribute(.unique) var id: UUID
    var date: Date
}
//struct Movement: Codable, Identifiable{
//    var id: UUID
////    var drink: String
////    var points: Int
//    var itemID: UUID
////    var value: Int
//    var date: Date
//    
//    init(itemID: UUID, points: Int = 0, date: Date = .now) {
////        self.drinkID = drinkID
//        self.id = UUID()
////        self.drink = drink
////        self.points = points
//        self.itemID = itemID
//        self.date = date
//    }
//}
//
//extension Movement {
////    static let empty = Movement()
//}
