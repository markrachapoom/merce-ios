//
//  StorageViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/22.
//

import Foundation
import Firebase

class StorageViewModel: ObservableObject {
    
    func uploadImage() -> Void {
        
//        // Data in memory
//        let data = Data()
//
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
//        }
    }
}
