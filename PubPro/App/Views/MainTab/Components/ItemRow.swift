//
//  ItemRow.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct ItemRow: View {
    let item: PubItem

    
    init(_ item: PubItem) {
        self.item = item
    }
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Image(systemName: "cup.and.saucer.fill")
            }
            .frame(width: 24, height: 24)
            .padding(12)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack {
                    Text(item.description)
                    if item.itemType == .consumption {
                        Text("\(item.points) Points")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                }
                .font(.caption2)
            }
            Spacer(minLength: 0)
            VStack {
                if item.itemType == .consumption, let formattedPrice = NumberFormatter.moneyFormatter.string(from: NSNumber(floatLiteral: item.price)) {
                    Text(formattedPrice)
                } else {
                    Text("\(item.points) Pts.")
                        .foregroundStyle(.red)
                }
            }
            .font(.title)
            .fontWeight(.semibold)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        }
    }
}

#Preview {
    VStack {
        ItemRow(PubItem.cafe)
        ItemRow(PubItem.mojitoReward)
    }
        .padding(24)
}
