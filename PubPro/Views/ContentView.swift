//
//  ContentView.swift
//  PubPro
//
//  Created by Ancel Dev account on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showToast = false
    @State private var emailSent = false
    var body: some View {
        VStack {
            Button("Send") {
                withAnimation {
                    emailSent.toggle()
                    showToast.toggle()
                }
            }
        }
        .toast(toastView: Toast(dataModel: ToastDataModel(title: "Success", image: "checkmark"), show: $showToast), show: $showToast)
    }
}
//    private func writeDB() {
//        Task {
//            
//            let drinksOK = await Repositories.updateItemsDB(for: Drink.drinks, collection: "drinksDataBase")
//            if drinksOK {
//                let rewardsOK = await Repositories.updateItemsDB(for: Reward.rewards, collection: "rewardsDataBase")
//                if rewardsOK {
//                    print("Database updated")
//                }
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
