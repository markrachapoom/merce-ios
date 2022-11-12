//
//  UserModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import Foundation

struct MerceUser: Codable {
    var type: String?
    var name: String?
    var username: String?
    var bio: String?
    var profileImageURL: String?
    var coverImageURL: String?
     
    static let allEntrepreneurs: [MerceUser] = Bundle.main.decode(file: "entrepreneurs.json")
    
    static let sampleEntrepreneur: MerceUser = allEntrepreneurs[0]
    static let markrachapoom: MerceUser = allEntrepreneurs[allEntrepreneurs.count - 1]
}
