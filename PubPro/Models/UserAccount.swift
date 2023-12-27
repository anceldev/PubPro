//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import Foundation
import SwiftData


/**
 UserAccount model to store Users data an movements
 */
@Model
class UserAccount {
    var name: String
    var email: String
    var phone: String
    var role: Role
    @Attribute(.unique) var uid: String
    @Relationship(deleteRule: .cascade) var movements = [Movement]()
    
    init(name: String = "", email: String = "", phone: String = "", role: Role = .unasigned, uid: String = "") {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
        self.uid = uid
    }
}

/// Extensíon used to get url of the container.
extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found"
        }
    }
}

/// Users role
enum Role: Codable {
    case unasigned
    case user
    case admin
}

/// Static var for testing
extension UserAccount {
    static var test = UserAccount(name: "Ancel", email: "ancel@gmail.com", phone: "983983983", uid: "user1")
}
