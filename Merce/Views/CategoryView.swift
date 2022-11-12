//
//  CategoryView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct CategoryView: View {
    
    let category: Category
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            Color.black
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                    }
                }//: VSTACK
                .padding(.vertical, K.topSafeArea + 26)
                .frame(height: 100)
            }//: SCROLLVIEW
            .background(Color.black)
            
            VStack {
                HStack {
                    
                    Button(action: {
                        K.impactOccur()
                        dismiss()
                    }, label: {

                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black.opacity(0.5))
                            .overlay {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                    })
                    
                    Spacer()
                    
                    Text("\(category.title)")
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
                        )
                )//: BACKGROUND
                
                Spacer()
            }//: VSTACK
            .edgesIgnoringSafeArea(.top)
            
        }//: ZSTACK
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(false)
        .navigationTitle(category.title)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(title: "Title", description: "Description"))
    }
}
