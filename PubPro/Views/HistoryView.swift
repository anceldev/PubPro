//
//  HistoryView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct HistoryView: View {
    
//    @Environment(ItemsViewModel.self) var itemsViewModel
//    @Environment(UserViewModel.self) var userViewModel
    
    var body: some View {
        VStack {
//            VStack {
//                TitleView(title: "History Points")
//            }
//            .padding(33)
//        
//            ScrollView(.vertical) {
//                VStack{
//                    if !userViewModel.user.movements.isEmpty {
//                        ForEach(userViewModel.user.movements) { movement in
//                            ItemRow(item: itemsViewModel.getItem(for: movement.itemID))
//                        }
//                        .padding(.horizontal, 15)
//                        .padding(.vertical, 3)
//                    } else {
//                        VStack {
//                            Text("You dont have any movements at the moment")
//                                .font(.custom("RobotoCondensed-Regular", size: 38))
//                                .foregroundStyle(.beerOrange)
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(15)
//                    }
//                }
//            }
//            Spacer()
        }
        .background(.ppDarkWhite)
    }
}

#Preview {
    //    return HistoryView()
    //        .environment(ItemsViewModel())
    //        .environment(UserViewModel())
    HistoryView()
}
