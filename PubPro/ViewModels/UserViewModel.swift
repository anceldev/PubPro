//
//  UserViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 25/12/23.
//

import Foundation
import SwiftData
import Observation

@Observable
class UserViewModel {
    var modelContext: ModelContext? = nil
    var user: UserAccount? = nil
}
