//
//  Constant.swift
//  Serendipity
//
//  Created by Mark Rachapoom on 2022/10/05.
//

import Foundation
import SwiftUI

struct K {
    static let baseURL = "https://serendipity-git-main-ios-monument.vercel.app"
    static let appSerendipityBaseURL = "https://app.serendipity.lol"
    
    static var topSafeArea: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0
    }
    
    static var bottomSafeArea: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
    
    static let rowPaddingVertical = 6.0
    static let fontSize = 15.5
    static let navigationBarHeight: CGFloat = 50.0
    static let coverImageHeight: CGFloat = 175
    
    // MARK: - HAPTIC FEEDBACK
    
    @AppStorage(wrappedValue: true, "isHapticsOn") static var isHapticsOn
    @AppStorage(wrappedValue: "Light", "selectedHaptic") static var selectedHaptics
    
    // Available impacts
    static let allImpacts: [Impact] = [
        Impact(name: "Soft", style: .soft),
        Impact(name: "Light", style: .light),
        Impact(name: "Rigid", style: .rigid),
        Impact(name: "Medium", style: .medium),
        Impact(name: "Heavy", style: .heavy)
    ]
    
    
    // Trigger Haptic
    static func impactOccur() -> Void {
        if isHapticsOn {
            allImpacts.enumerated().forEach { (index, impact) in
                if selectedHaptics == impact.name {
                    UIImpactFeedbackGenerator(style: impact.style).impactOccurred()
                }
            }
        }
    }
    
    
    static func selectionChangeHapticOccur() {
        if isHapticsOn {
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }

    
    static func notificationHapticOccur(style: UINotificationFeedbackGenerator.FeedbackType) -> Void {
        if isHapticsOn {
            UINotificationFeedbackGenerator().notificationOccurred(style)
        }
    }
    
    static let categories: [AnyObject] = [
        
    ]
    
}

enum HTTP_METHOD: String {
    case POST = "POST"
    case GET = "GET"
}

func jsonStringify(data: Data) {
    if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
        print(jsonString)
    }
}
