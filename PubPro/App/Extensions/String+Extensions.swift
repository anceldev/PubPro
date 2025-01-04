//
//  String+Extensions.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

extension String {
    var isEmptyOrWithespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
extension String {
//    func generateQRCode() -> UIImage? {
//        let data = self.data(using: String.Encoding.ascii)
//        
//        if let filter = CIFilter(name: "CIQRCodeGenerator") {
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 3, y: 3)
//            if let output = filter.outputImage?.transformed(by: transform) {
//                return UIImage(ciImage: output)
//            }
//        }
//        return nil
//    }
    func generateQRCode(size: CGFloat = 200) -> UIImage? {
            let context = CIContext()
            let filter = CIFilter.qrCodeGenerator()
            
            // Convert string to data
            guard let data = self.data(using: .utf8) else { return nil }
            filter.setValue(data, forKey: "inputMessage")
            
            // Get output image
            guard let outputImage = filter.outputImage else { return nil }
            
            // Scale the image
            let scale = size / outputImage.extent.size.width
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            let scaledImage = outputImage.transformed(by: transform)
            
            // Convert to UIImage
            guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }
            return UIImage(cgImage: cgImage)
        }
}
