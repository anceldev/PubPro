//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData

@Model
class User {
    var uid: String // Firestore document reference for backup
    var name: String
    var email: String
    var phone: String
    var role: Role
    var points: Int
    @Relationship(deleteRule: .cascade, inverse: \Movement.user) var movemements: [Movement]?
    
    init(uid: String = "", name: String = "", email: String = "", phone: String = "", role: Role = .user, points: Int = 60, movemements: [Movement]? = []) {
        self.uid = uid
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
        self.points = points
        self.movemements = movemements
    }
}

enum Role: String, Codable{
    case user = "User"
    case admin = "Admin"
    case superadmin = "Superadmin"
}
