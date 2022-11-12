//
//  SectionView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct SectionView<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(alignment: .center) {
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .bold, design: .default))
                        .foregroundColor(Color(.secondaryLabel))
                    
                    
                }//: HSTACK
                
                Spacer()
            }
            .padding(.horizontal)
            
            content
            
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "Test") {
            
        }
    }
}
