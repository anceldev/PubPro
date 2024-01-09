//
//  HistoryView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct HistoryView: View {
    
    let movements: [Movement]
    
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "History Points")
            }
            .padding(33)
            ForEach(movements) { movement in
                ItemRow(item: Drink.drinks.first(where: { movement.itemID == $0.id })!)
                    .padding(15)
            }
            .listStyle(.inset)
            Spacer()
        }
        .background(.ppDarkWhite)
    }
}

#Preview {
    HistoryView(movements: User.empty.movements)
}
