//
//  MerceSong.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/27.
//

import Foundation
import MusicKit

struct MerceSong: Codable {
    var id: String
    var title: String?
    var url: String?
    var albumTitle: String?
    var artistName: String?
    var artistURL: URL?
    var artists: [MerceUser]?
    var artwork: Artwork?
    var conposers: [MerceUser]?
    var duration: Date?
    var genres: [String]?
    var hasLyrics: Bool?
    var musicVideos: [String]?
    var playCount: Int?
    var releaseDate: Date?
    
    static let sampleSongs: [MerceSong] = [
        MerceSong(
            id: "1",
            title: "Wealth Equals Freedom",
            url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
            artists: [MerceUser.markrachapoom,MerceUser.akirathedon],
            artwork: Artwork(url: "https://cdn.shopify.com/s/files/1/0256/1091/1837/products/a0863826809_10_1200x.jpg?v=1668696036")
        ),
        MerceSong(
            id: "2",
            title: "True Wealth Creation",
            url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
            artists: [MerceUser.markrachapoom,MerceUser.akirathedon],
            artwork: Artwork(url: "https://cdn.shopify.com/s/files/1/0256/1091/1837/products/a0863826809_10_1200x.jpg?v=1668696036")
        ),
        MerceSong(
            id: "3",
            title: "Society Always Wants New Things",
            url: "http://docs.google.com/uc?export=open&amp;id=1lLV_J_GY7iAk_F0HBu4BvYll2UZgx_rE",
            artists: [MerceUser.markrachapoom,MerceUser.akirathedon],
        artwork: Artwork(url: "https://cdn.shopify.com/s/files/1/0256/1091/1837/products/a0863826809_10_1200x.jpg?v=1668696036"))
    ]
}

struct Artwork: Codable {
    var bgColor: String?
    var height: CGFloat?
    var width: CGFloat?
    var textColor1: String?
    var textColor2: String?
    var textColor3: String?
    var textColor4: String?
    var url: String?
}
