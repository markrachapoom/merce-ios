//
//  Buzz.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/21.
//

import Foundation
import AVKit

struct Buzz: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
