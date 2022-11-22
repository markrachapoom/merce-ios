//
//  MerceError.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/22.
//

import Foundation

enum MerceError: Error {
    
    case invalidUid
    case invalidImageData
    case failedToUpdateCurrentUserData
    case noCurrentUser
    
    var errorMessage: String {
        switch self {
        case .invalidImageData:
            return "Invalid image data"
        case .invalidUid:
            return "Invalid Firebase user id"
        case .failedToUpdateCurrentUserData:
            return "Failed to update current user data"
        case .noCurrentUser:
            return "No current user"
        }
    }
    
}
