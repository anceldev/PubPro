//
//  NumberFormatter+Extensions.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation

extension NumberFormatter {
    static let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}
