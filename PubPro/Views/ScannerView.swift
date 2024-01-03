//
//  ScannerView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import SwiftUI

struct ScannerView: View {
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan QR code"
    
    var body: some View {
        Text("Scanner View for admin")
    }
}

#Preview {
    ScannerView()
}
