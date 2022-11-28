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
            url: "https://firebasestorage.googleapis.com/v0/b/merce-bdf80.appspot.com/o/songs%2FtfquvSq1KBPbmslIRdL9%2Fsong%2FAkira%20The%20Don%20%26%20Naval%20Ravikant%20-%20How%20To%20Get%20Rich-%20Vol.%201%20-%2001%20Wealth%20Equals%20Freedom.mp3?alt=media&token=d1a328ad-525b-471d-b250-51896985a12d",
            artwork: Artwork(url: "https://cdn.shopify.com/s/files/1/0256/1091/1837/products/a0863826809_10_1200x.jpg?v=1668696036")
        ),
        MerceSong(
            id: "2",
            title: "True Wealth Creation",
            url: "https://firebasestorage.googleapis.com/v0/b/merce-bdf80.appspot.com/o/songs%2FtfquvSq1KBPbmslIRdL9%2Fsong%2FAkira%20The%20Don%20%26%20Naval%20Ravikant%20-%20How%20To%20Get%20Rich-%20Vol.%201%20-%2002%20True%20Wealth%20Creation.mp3?alt=media&token=ca07bf9e-6c70-4ad2-aaea-0bdfc86ecbcc",
            artwork: Artwork(url: "https://cdn.shopify.com/s/files/1/0256/1091/1837/products/a0863826809_10_1200x.jpg?v=1668696036")
        ),
        MerceSong(id: "3", title: "Society Always Wants New Things", url: "https://firebasestorage.googleapis.com/v0/b/merce-bdf80.appspot.com/o/songs%2FtfquvSq1KBPbmslIRdL9%2Fsong%2FAkira%20The%20Don%20%26%20Naval%20Ravikant%20-%20How%20To%20Get%20Rich-%20Vol.%201%20-%2008%20Society%20Always%20Wants%20New%20Things.mp3?alt=media&token=e6948403-b3f4-4400-8659-01d5b0eed3f9"),
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
