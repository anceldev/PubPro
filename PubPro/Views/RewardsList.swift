//
//  RewardsList.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct RewardsList: View {
    
    var items = Reward.rewards
    
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "Rewards")
            }
            .padding(33)
            ForEach(items, id: \.id) { item in
                ItemRow(item: item)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 3)
            Spacer()
        }
        .background(.ppDarkWhite)
    }
}

#Preview {
    RewardsList()
}
