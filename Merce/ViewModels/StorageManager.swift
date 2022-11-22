//
//  StorageManager.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/22.
//

import Foundation
import FirebaseStorage

class StorageManager {
    
    static let shared = StorageManager()
    
    private let storageRef = Storage.storage().reference()
    
    enum ImagePath: String {
        case coverImage = "coverImage"
        case profileImage = "profileImage"
    }
    
    public func uploadImage(uid: String?, path: ImagePath, imageData: Data?, completion: @escaping (Result<String, MerceError>) -> Void) -> Void {
        
        guard let uid = uid else {
            completion(.failure(MerceError.invalidUid))
            return
        }
        
        guard let imageData = imageData else {
            completion(.failure(MerceError.invalidImageData))
            return
        }
        
        // Create a reference to the file you want to upload
        let usersRef = storageRef.child("users/\(uid)/\(path.rawValue)")
        
        print("Uploading with uid: \(uid)")
        
        // Upload the file to the path "users/${uid}"
        let uploadTask = usersRef.putData(imageData, metadata: nil) { (metadata, error) in
            
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            print("Media size: \(size)")
            
            // You can also access to download URL after upload.
            usersRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                completion(.success(downloadURL.absoluteString))
                print("Download url: \(downloadURL)")
            }
        }
    }
    
    
}
