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
}

//type: "user",
//name: "Naval Ravikant",
//username: "naval",
//bio: "I'm Naval, a serial entrepreneur, investor, and writer. I'm the founder of AngelList, AngelList Syndicates, AngelList Talent, and AngelList Venture. I'm also an investor in over 100 startups, including Twitter, Uber, and Coinbase. I'm the author of the best-selling book, 'The Ultimate Startup Guide', and I write a daily newsletter called 'AngelList Daily'.",
//profileImageURL: "https://pbs.twimg.com/profile_images/1256841238298292232/ycqwaMI2_400x400.jpg",
//coverImageURL: "https://pbs.twimg.com/profile_banners/745273/1588490328/1500x500",
