//
//  StorageManager.swift
//  PubPro
//
//  Created by Ancel Dev account on 10/1/24.
//

import Firebase
import Foundation
import FirebaseStorage
import SwiftUI

/**
 Storage manager to upload profile images about users
 */
@Observable
class StorageManager {
    static let storage = Storage.storage()
 
    /**
     Uploads an avatar image to Storage from a UIImage
     */
    static func uploadAvatar(image: UIImage) -> Bool {
        let storageRef = storage.reference().child("usersProfilePhotos/image.jpg") // Reference to image
        let resizedImage = image.ascpectFittedToHeight(400)
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { metadata, error in
                if let error = error {
                    fatalError("Error while uploading file: \(error.localizedDescription)")
                }
                if let metadata = metadata {
                    print("Metadata: \(metadata)")
                } else {
                    fatalError("Wrong metadata")
                }
            }
        }
        return true
    }
    
    /**
     Deletes an avatar image from Storage
     */
    func deleteAvatar(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting avatar: \(error.localizedDescription)")
            }
        }
    }
}

/**
 Extensión used to compress and resize image
 */
extension UIImage {
    func ascpectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
