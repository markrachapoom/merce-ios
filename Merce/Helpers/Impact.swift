//
//  Impact.swift
//  Serendipity
//
//  Created by Mark Rachapoom on 2022/10/14.
//

import Foundation
import SwiftUI

struct Impact: Identifiable, Hashable {
    
    let id: String
    let name: String
    let style: UIImpactFeedbackGenerator.FeedbackStyle
    var isSelected: Bool
    
    init(name: String, style: UIImpactFeedbackGenerator.FeedbackStyle, isSelected: Bool = false) {
        self.id = UUID().uuidString
        self.name = name
        self.style = style
        self.isSelected = isSelected
    }
    
    // MARK: - METHODS
    
    mutating func toggleSelection() -> Void {
        self.isSelected.toggle()
    }
    
}
