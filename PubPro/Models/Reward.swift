//
//  Reward.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import Foundation
import SwiftData

//@Model
//class Rewards {
//    @Relationship(deleteRule: .cascade) var rewards = [Reward]()
//    init(rewards: [Reward] = [Reward]()) {
//        self.rewards = rewards
//    }
//}
@Model
class Reward {
    var id: Int
    var name: String
    var descReward: String
    var value: Int
    var lastUpdate: Date
    var nameIcon: String {
        name + "-100"
    }
    
    init(id: Int, name: String, descReward: String, value: Int, lastUpdate: Date = .now) {
        self.id = id
        self.name = name
        self.descReward = descReward
        self.value = value
        self.lastUpdate = lastUpdate
    }
}
