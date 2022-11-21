//
//  MediaFile.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/21.
//

import Foundation

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    
    static let allMediaFiles: [MediaFile] = [
        MediaFile(url: "buzz-1", title: "Buzz 1"),
        MediaFile(url: "buzz-2", title: "Buzz 2"),
        MediaFile(url: "buzz-3", title: "Buzz 3"),
        MediaFile(url: "buzz-4", title: "Buzz 4"),
        MediaFile(url: "buzz-5", title: "Buzz 5")
    ]
}
