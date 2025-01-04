//
//  PubItemsList.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct PubItemsList: View {
    let items: [PubItem]
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(items) { item in
                    ItemRow(item)
                }
            }
        }
    }
}

#Preview {
    PubItemsList(items: [PubItem.cafe, PubItem.mojitoReward, PubItem.mojito])
        .padding(24)
}
