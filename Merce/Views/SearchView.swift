//
//  SearchView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var searchVM: SearchViewModel
    
    @State private var searchText: String = ""
    
    @State private var showSearchModal: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black
                
                VStack(spacing: 0) {
                    HStack {
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.tertiaryLabel))
                                .font(.system(size: 20))
                            
                            if (showSearchModal) {
                                TextField("Search Musics", text: $searchText)
                                    .focused($isTextFieldFocused)
                                    .textInputAutocapitalization(.never)
                                    .onChange(of: searchText) { newSearchText in
                                        searchVM.fetchSearch(from: newSearchText)
                                    }
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(searchVM.searchResults, id: \.username) { user in
                                NavigationLink(destination: ProfileView(user: user)) {
                                    SearchRowView(item: user)
                                }//: NAVIGATION LINK
                            }//: LOOP
                        }//: LAZYVSTACK
                        .padding(.bottom, 128)
                    }//: SCROLLVIEW
                    
                }//: VSTACK
                
            }//: ZSTACK
        }//: NAVIGATION VIEW
    }
}

struct SearchRowView: View {
    
    let item: MerceUser
    
    var body: some View {
        HStack {
            
            // IMAGE
            if let type = item.type, type == "user" {
                AsyncImage(url: URL(string: item.profileImageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .foregroundColor(.secondaryBackgroundColor)
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                
                // Name
                Text("\(item.name ?? "")")
                
                // Username
                Text("@\(item.username ?? "")")
                    .foregroundColor(Color(.secondaryLabel))
            }//: VSTACK
            .font(.system(size: K.fontSize))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 13))
            
        }//: HSTACK
        .padding(.horizontal)
        .frame(height: 64)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchViewModel())
            .preferredColorScheme(.dark)
    }
}
