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
    var name: String
    var email: String
    var phone: String
    var uid: String
    @Relationship(deleteRule: .cascade) var movements = [Movement]()
    
    init(name: String = "", email: String = "", phone: String = "", uid: String = "") {
        self.name = name
        self.email = email
        self.phone = phone
        self.uid = uid
    }
}


extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found"
        }
    }
}
