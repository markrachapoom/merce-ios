//
//  SearchView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var showMusicPlayerModal: Bool
    @Binding var translation: CGSize
    
    @State private var searchText: String = ""
    
    @State private var showSearchModal: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
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
                                .foregroundColor(Color(.secondaryLabel))
                                .opacity(searchText.isEmpty ? 0 : 1)
                        })
                    }//: HSTACK
                    .padding(.horizontal)
                    .frame(height: 48)
                    .background(
                        Capsule()
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundColor(Color(.separator))
                            .background(.black)
                    )//: BACKGROUND
                    
                    if (showSearchModal) {
                        Button(action: {
                            withAnimation {
                                K.impactOccur()
                                showSearchModal = false
                                isTextFieldFocused = false
                                searchText.removeAll()
                            }
                        }, label: {
                            Text("Cancel")
                        })
                    }
                }//: hstack
                .padding(.all)
                .onTapGesture {
                    withAnimation {
                        if (!showSearchModal) {
                            showSearchModal = true
                            isTextFieldFocused = true
                        }
                    }
                }
                
                Spacer()
                
            }//: VSTACK
            
            BottomMusicPlayerView(translation: $translation, showMusicPlayerModal: $showMusicPlayerModal)
            
        }//: ZSTACK
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showMusicPlayerModal: .constant(false), translation: .constant(.zero))
            .preferredColorScheme(.dark)
    }
}
