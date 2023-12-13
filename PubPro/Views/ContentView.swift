//
//  ContentView.swift
//  PubPro
//
//  Created by Ancel Dev account on 26/11/23.
//

import QRCode
import SwiftUI

struct ContentView: View {
    
//    let qr = QRCode(string: "1")
    let qr = QRCode(string: "1", size: CGSize(width: 400, height: 400))

    @State var img: Image?
    @State var showImage = false
    
    
    var body: some View {
        VStack {
            VStack {
                if showImage {
                    img!
                        .resizable()
                        .frame(width: 300, height: 300)
                }
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Generate QR") {
                let myQR: UIImage? = try? qr?.image()
                if let uiImage = myQR {
                    img = Image(uiImage: uiImage)
                }
                showImage.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
