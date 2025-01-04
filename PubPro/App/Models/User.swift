//
//  User.swift
//  PubPro
//
//  Created by Ancel Dev account on 16/8/24.
//

import Foundation

enum UserType: Decodable {
    case user
    case admin
}

struct User: Decodable {
    let id: UUID
    let name: String
    let email: String
    let points: Int
    let userType: UserType
}


extension User {
    static let preview: User = .init(
        id: UUID(),
        name: "nico",
        email: "nico@mail.com",
        points: 225,
        userType: .user
    )
}
