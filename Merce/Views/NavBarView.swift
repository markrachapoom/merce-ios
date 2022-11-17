//
//  NavBarView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct NavBarView: View {
    
    let title: String
    let withBackButton: Bool
    
    init(title: String, withBackButton: Bool = true) {
        self.title = title
        self.withBackButton = withBackButton
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                
                if (withBackButton) {
                    Button(action: {
                        K.impactOccur()
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 22))
                    })//: BUTTON
                }
                
                Spacer()
                
                Text(title)
                    .font(.navigationInlineTitle())
                
                Spacer()
                
                
                if (withBackButton) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 22))
                        .opacity(0)
                }
                
            }//: HSTACK
            .frame(height: K.bottomTabBarHeight)
            .padding(.top, K.topSafeArea)
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
