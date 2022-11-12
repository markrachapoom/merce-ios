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
            
            NavBarView(title: category.title)
            
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
