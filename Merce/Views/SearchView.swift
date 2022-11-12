//
//  SearchView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct SearchView: View {
    
//    @Binding var showMusicPlayerModal: Bool
//    @Binding var translation: CGSize
    
    @State private var searchText: String = ""
    
    @State private var showSearchModal: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                VStack {
                    HStack {
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.tertiaryLabel))
                                .font(.system(size: 20))
                            
                            if (showSearchModal) {
                                TextField("Search Musics", text: $searchText)
                                    .focused($isTextFieldFocused)
                            } else {
                                Text("Search Musics")
                                    .foregroundColor(Color(.tertiaryLabel))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                K.impactOccur()
                                searchText.removeAll()
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.secondaryLabel))
                                    .opacity(searchText.isEmpty ? 0 : 1)
                            })
                        }//: HSTACK
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(
                            Capsule()
                            //                            .stroke(style: StrokeStyle(lineWidth: 1))
                            //                            .foregroundColor(Color(.separator))
                                .foregroundColor(Color.secondaryBackgroundColor)
                                .background(.black)
                        )//: BACKGROUND
                        
                        if (showSearchModal) {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    K.impactOccur()
                                    showSearchModal = false
                                    isTextFieldFocused = false
                                    searchText.removeAll()
                                }
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    }//: HSTACK
                    .padding(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            K.impactOccur()
                            if (!showSearchModal) {
                                showSearchModal = true
                                isTextFieldFocused = true
                            }
                        }
                    }
                    
                    Spacer()
                    
                }//: VSTACK
                
            }//: ZSTACK
        }//: NAVIGATION VIEW
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
