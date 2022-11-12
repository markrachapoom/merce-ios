//
//  Category.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import Foundation

struct Category: Codable {
    var title: String
    var description: String
    
    static let allCategories: [Category] = [
        Category(title: "Mental Model", description: "The best way to make intelligent decisions (~100 models explained)."),
        Category(title: "Productivity", description: "How to be more productive and get more things done."),
        Category(title: "Life", description: "How to live a better life."),
        Category(title: "Health", description: "How to be healthy and live longer."),
        Category(title: "Finance", description: "How to manage your money and become rich."),
        Category(title: "Relationship", description: "How to have a better relationship with your friends and family."),
        Category(title: "Career", description: "How to have a better career."),
        Category(title: "Emotion", description: "How to manage your emotions and be happier.")
    ]
}
