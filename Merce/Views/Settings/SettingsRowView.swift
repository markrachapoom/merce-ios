//
//  SettingsRowView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct SettingsRowView<Content: View>: View {
    
    let label: String
    let iconName: String
    let color: Color
    let trailingContent: Content
    
    init(label: String, iconName: String, color: Color = Color(.label), @ViewBuilder trailingContent: () -> Content) {
        self.label = label
        self.iconName = iconName
        self.color = color
        self.trailingContent = trailingContent()
    }
    
    var body: some View {
        HStack {
            
            Label(label, systemImage: iconName)
            
            Spacer()
            
            trailingContent
            
        }//: HSTACK
        .foregroundColor(color)
        .padding(.horizontal)
        .frame(height: 40)
        .background(Color(.systemBackground))
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(label: "Label", iconName: "star", trailingContent: {
            
        })
    }
}
