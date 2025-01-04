//
//  Endpoints.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import PubProSharedDTO

enum EndpointURL {
    
    case signUp
    case signIn
    case pubItems(UUID)
    case getPubItemsByType(UUID, ItemType)
    
    private static let baseUrlPath = "http://127.0.0.1:8080/api"
    
    var url: URL {
        switch self {
        case .signUp:
            URL(string: "\(EndpointURL.baseUrlPath)/sign-up")!
        case .signIn:
            URL(string: "\(EndpointURL.baseUrlPath)/sign-in")!
        case .pubItems(let userId): // This case is for get and post methods
            URL(string: "\(EndpointURL.baseUrlPath)/admin/\(userId)/items")!
        case .getPubItemsByType(let userId, let type):
            URL(string: "\(EndpointURL.baseUrlPath)/admin/\(userId)/items/\(type.rawValue)")!
        }
    }
}
