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
    var date: Date
    var item: Item
    var user: User?
    
    init(date: Date = .now, item: Item, user: User? = nil) {
        self.date = date
        self.item = item
        self.user = user
    }
}
