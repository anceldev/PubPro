//
//  NavigationState.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import Observation

enum PubProError: Error {
    case signIn
    case signUp
}

enum Route: Hashable {
    case signIn
    case signUp
    case pubItemsList
    case profile
    case main
}

@Observable
final class NavigationState {
    var routes: [Route] = []
    var errorWrapper: ErrorWrapper?
}
