//
//  Utils.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import Foundation
import SwiftUI

func getFormatPlayerTime(interval: TimeInterval?) -> String {
    guard let interval = interval else { return ""}
    return "\(Int(interval/60)):\(Int(interval.truncatingRemainder(dividingBy: 60)) <= 9 ? "0" : "")\(Int(interval.truncatingRemainder(dividingBy: 60)))"
}
