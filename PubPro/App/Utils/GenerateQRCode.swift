//
//  GenerateQRCode.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import SwiftUI

//extension String {
//    func generateQRCode(from string: String) -> UIImage? {
//        let data = string.data(using: String.Encoding.ascii)
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
//}
