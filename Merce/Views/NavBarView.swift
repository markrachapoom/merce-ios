//
//  NavBarView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct NavBarView: View {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                
                Button(action: {
                    K.impactOccur()
                    dismiss()
                }, label: {
                    CircleIcon(iconName: "arrow.left")
                })//: BUTTON
                
                Spacer()
                
                Text(title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Circle()
                    .frame(width: 32, height: 32)
                    .opacity(0)
                
            }//: HSTACK
            .padding(.top, K.topSafeArea)
            .padding(.vertical, 13)
            .padding(.horizontal)
            .background(
                VisualEffectView(blurEffect: .dark)
                    .overlay(
                        Color.black.opacity(0.65)
                    )//: OVERLAY
            )//: BACKGROUND
            
            Spacer()
        }//: VSTACK
        .edgesIgnoringSafeArea(.top)
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(title: "Life")
    }
}
