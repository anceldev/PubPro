//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var phone: String
    var role: Role
    var movements = [Movement]()
    var points: Int = 0
    
    init(name: String = "", email: String = "", phone: String = "", role: Role = .user) {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
    }
}

/// Users role
enum Role: String, Codable {
    case user = "User"
    case admin = "Admin"
}
extension User {
    static var empty = User()
}
