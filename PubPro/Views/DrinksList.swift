//
//  DrinksList.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct DrinksList: View {
    let drinks: [Drink]
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "Drinks")
            }
            .padding(33)
            ForEach(drinks, id: \.id) { drink in
                ItemRow(item: drink)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 3)
            Spacer()
        }
        .background(.ppDarkWhite)
    }
}

#Preview {
    DrinksList(drinks: Drink.drinks)
}
