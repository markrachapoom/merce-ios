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
}
