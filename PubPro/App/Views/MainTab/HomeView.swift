//
//  HomeView.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI



struct HomeView: View {
    let user: User
    
    var qrCode: Image? {
        guard let uiImage = user.id.uuidString.generateQRCode(size: 200) else {
            return nil
        }
        return Image(uiImage: uiImage)
        
    }
    var body: some View {
        VStack {
            Text("Welcome \(user.name)!")
                .font(.title)
                .fontWeight(.bold)
            Text("You have \(user.points)")
                .font(.title3)
                .fontWeight(.bold)
            if let qrImage = qrCode {
                qrImage
                    .resizable()
                    .frame(width: 320, height: 320)
            }
            Spacer()
        }
        .padding(24)
    }
}

#Preview {
    HomeView(user: User.preview)
}
