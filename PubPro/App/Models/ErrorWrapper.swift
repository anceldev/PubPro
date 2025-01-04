//
//  ErrorWraper.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}
