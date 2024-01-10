//
//  ItemRow.swift
//  PubPro
//
//  Created by Ancel Dev account on 8/1/24.
//

import SwiftUI

/**
 Recives an item and creates its color.
 */
struct ItemRow: View {
    
    let item: Item
    let colorItem: Color
    
    init(item: Item){
        self.item = item
        if item is Drink{ self.colorItem = Color.beerOrange }
        else { self.colorItem = Color.ppGreen }
    }
    
    var body: some View {
        HStack {
            HStack(alignment: .top) {
                VStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: 66, height: 66)
                        .padding(.bottom, 2)
                }
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.custom("Styleturn", size: 22))
                    
                    Text(item.descriptionItem)
                        .font(.custom("RobotoCondensed-Regular", size: 12))
                        .lineLimit(2)
                }
                .padding(.top, 10)
            }
            .padding(3)
            Spacer()
            HStack(alignment: .center) {
                VStack(alignment: .trailing) {
                    let sign = item is Drink ? "+" : "-"
                    
                    Text("\(sign)\(item.value)")
                        .foregroundStyle(colorItem)
                        .font(.custom("RobotoCondensed-Black", size: 48))
                }
                .padding(.trailing, 12)
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .padding(0)
    }
}

#Preview {
    ItemRow(item: Drink.drinks[0])
}
