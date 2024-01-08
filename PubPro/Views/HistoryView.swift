//
//  HistoryView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct HistoryView: View {
    
    var movements: [Movement]
    
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "History Points")
            }
            .padding(33)
            List(movements) { movement in
                HStack {
                    VStack {
                        Image(systemName: "wineglass")
                    }
                    VStack {
                        Text(movement.drink)
                    }
                    Spacer()
                    VStack{
                        Text("\(movement.points)")
                            .foregroundStyle(movement.points < 0 ? .red : .blue)
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    HistoryView(movements: User.empty.movements)
}
