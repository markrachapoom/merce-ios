//
//  CircleIcon.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct CircleIcon: View {
    
    let iconName: String
    
    var body: some View {
        Circle()
            .frame(width: 34, height: 34)
//            .foregroundColor(.black.opacity(0.5))
            .foregroundColor(.clear)
            .background(
                VisualEffectView(blurEffect: .dark)
                    .clipShape(Circle())
            )
            .overlay {
                Image(systemName: iconName)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
            }
    }
}

struct CircleIcon_Previews: PreviewProvider {
    static var previews: some View {
        CircleIcon(iconName: "geapshape")
    }
}
