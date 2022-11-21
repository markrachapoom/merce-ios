//
//  UserModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import Foundation

struct MerceUser: Codable {
    var type: String?
    var uid: String?
    var coverImageURL: String?
    var profileImageURL: String?
    var givenName: String?
    var isVerified: Bool?
    var username: String?
    var bio: String?
    var email: String?
    var followingCount: Int?
    var followersCount: Int?
    var joinedDate: Date?
     
    static let allEntrepreneurs: [MerceUser] = Bundle.main.decode(file: "entrepreneurs.json")
    
    static let sampleEntrepreneur: MerceUser = allEntrepreneurs[0]
    static let markrachapoom: MerceUser = allEntrepreneurs[allEntrepreneurs.count - 1]
}
