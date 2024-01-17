//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var phone: String
    var points: Int
    var role: Role?
    @Relationship(deleteRule: .cascade) var movements: [Movement]
    
    init(id: UUID = UUID(), name: String = "", email: String = "", phone: String = "", points: Int = 60, role: Role? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.points = points
        self.role = role
    }
}

enum Role {
    case admin
    case user
}
//struct User: Codable, Identifiable {
//    @DocumentID var id: String?
//    var name: String
//    var email: String
//    var phone: String
//    var role: Role
//    var movements: [Movement]
//    var points: Int = 60
//    var lastUpdateDrinks: Date? = nil
//    var lastUpdateRewards: Date? = nil
//    
//    
//    init(name: String = "", email: String = "", phone: String = "", role: Role = .user, movements: [Movement] = []) {
//        self.name = name
//        self.email = email
//        self.phone = phone
//        self.role = role
//        self.movements = movements
//    }
//}
//
///// Users role
//enum Role: String, Codable {
//    case user = "User"
//    case admin = "Admin"
//}
//extension User {
//    static var empty = User(name: "Username", movements: [Movement(itemID: Drink.drinks[0].id, date: .now)])
//}
