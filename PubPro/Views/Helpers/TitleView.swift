//
//  TitleView.swift
//  PubPro
//
//  Created by Ancel Dev account on 8/1/24.
//

import SwiftUI

struct TitleView: View {
    let title: String
//    let hasItems: Bool = false
    let hasTable: Bool
    init(title: String, hasTable: Bool = true) {
        self.title = title
        self.hasTable = hasTable
    }

    
    var bars: some View {
        VStack {
            Rectangle()
                .fill(.black)
                .frame(maxWidth: .infinity, minHeight: 2, maxHeight: 2)
            Rectangle()
                .fill(.black)
                .frame(maxWidth: .infinity, minHeight: 2, maxHeight: 2)
                .padding(.top, -4)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                bars
                VStack {
                    Text(title.uppercased())
                        .font(.custom("RobotoCondensed-Regular", size: 24))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .fixedSize()
                }
                bars
            }
            if hasTable {
                HStack {
                    
                    Text("ITEM")
                    Spacer()
                    Text("POINTS")
                }
                .font(.custom("RobotoCondensed-Bold", size: 14))
            }
        }
        .foregroundStyle(.ppDark)
    }
}
//
//#Preview {
//    TitleView(title: "History points")
//}
