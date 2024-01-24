//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData

@Model
class User: Codable {
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
    
    /// Codable protocol conformance
    enum CodingKeys: CodingKey {
        case uid, name, email, phone, role, points, movements
    }
    /// Decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = ""
        self.role = try container.decode(Role.self, forKey: .role)
        self.points = try container.decode(Int.self, forKey: .points)
        self.movemements = try container.decode([Movement].self, forKey: .movements)
    }
    /// Enconder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(role, forKey: .role)
        try container.encode(points, forKey: .points)
        try container.encode(movemements, forKey: .movements)
    }
}

enum Role: String, Codable{
    case user = "User"
    case admin = "Admin"
    case superadmin = "Superadmin"
}
