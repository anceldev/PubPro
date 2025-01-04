//
//  PubItemsList.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct PubItemsView: View {
    
    var body: some View {
        VStack {
            Text("Pub Items")
                .font(.title).bold()
            PubItemsList(items: [PubItem.cafe, PubItem.mojito, PubItem.mojitoReward])
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
    }
}

#Preview {
    PubItemsView()
}
