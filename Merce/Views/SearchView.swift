//
//  SearchView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    
                    TextField("Search musics", text: $searchText)
                    
                    Spacer()
                    
                    Button(action: {
                        K.impactOccur()
                        searchText.removeAll()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color(.secondaryLabel))
                            .opacity(searchText.isEmpty ? 0 : 1)
                    })
                }
                .padding(.horizontal)
                .frame(height: 48)
                .background(
                    Capsule()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundColor(Color(.separator))
                )
                .padding(.all)
//                .foregroundColor(Color(.separator))
                
                Spacer()
            }//: VSTACK
        }//: ZSTACK
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
