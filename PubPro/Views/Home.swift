//
//  Home.swift
//  PubPro
//
//  Created by Ancel Dev account on 13/12/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                Text("PubPro")
                    .font(.largeTitle)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged")
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Next")
                }

                Spacer()
                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    Home()
}
