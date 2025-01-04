//
//  PubItem.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import PubProSharedDTO

struct PubItem: Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var points: Int
    var price: Double
    var itemType: ItemType
}


extension PubItem {
    static let cafe = PubItem(
        id: UUID(),
        name: "Caffe",
        description: "Caffe americano",
        points: 10,
        price: 1.5,
        itemType: .consumption
    )
    
    static let mojito = PubItem(
        id: UUID(),
        name: "Mojito",
        description: "Mojito de hierba buena y menta",
        points: 25,
        price: 6.5,
        itemType: .consumption
    )
    
    static let mojitoReward = PubItem(
        id: UUID(),
        name: "Mojito",
        description: "Mojito de huerba buena y menta",
        points: 350,
        price: 0,
        itemType: .reward
    )
}
