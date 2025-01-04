//
//  UserDefaults+Extensions.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation

extension UserDefaults {
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdAsString)
        }
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}
