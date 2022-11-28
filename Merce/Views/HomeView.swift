//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    @EnvironmentObject private var searchVM: SearchViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
//    @Binding var showMusicPlayerModal: Bool
//    @Binding var translation: CGSize
    
    @Namespace private var musicPlayerNamespace
    
//    init(showMusicPlayerModal: Binding<Bool>, translation: Binding<CGSize>) {
//        self._showMusicPlayerModal = showMusicPlayerModal
//        self._translation = translation
//    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 21) {
                                
                                SectionView(title: "Recently Played") {
                                    
                                }
                                
                                
                                SectionView(title: "Artists") {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 13) {
                                            ForEach(searchVM.allArtists, id: \.username) { artist in
                                                NavigationLink(destination: ProfileView(user: artist)) {
                                                    AsyncImage(url: URL(string: artist.profileImageURL ?? "")) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                    } placeholder: {
                                                        Circle()
                                                            .foregroundColor(Color(.secondarySystemBackground))
                                                    }
                                                    .frame(width: 90, height: 90)
                                                    .clipShape(Circle())
                                                }//: NAVIGATIONLINK
                                            }//: LOOP
                                        }//: HSTACK
                                        .padding(.horizontal)
                                    }//: SCROLLVIEW
                                }
                                
                                SectionView(title: "Songs") {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 13) {
                                            ForEach(MerceSong.sampleSongs, id: \.id) { song in
                                                Button(action: {
                                                    playerVM.playSong(song)
                                                }, label: {
                                                    VStack(alignment: .leading) {
                                                        AsyncImage(url: URL(string: song.artwork?.url ?? "")) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFill()
                                                        } placeholder: {
                                                            Rectangle()
                                                                .foregroundColor(Color(.secondarySystemBackground))
                                                        }
                                                        .frame(width: 115, height: 115)
                                                        .cornerRadius(8)
                                                        
                                                        Text(song.title ?? "Unknown")
                                                            .foregroundColor(Color(.label))
                                                            .font(.system(size: K.fontSize))
                                                            .lineLimit(1)
                                                        
//                                                        if let artists = song.artists {
                                                        HStack {
                                                            Text(["Akira The Don", "Naval Ravikant"].joined(separator: ", "))
                                                                .foregroundColor(Color(.secondaryLabel))
                                                                .font(.system(size: K.fontSize))
                                                        }//: HSTACK
                                                        .lineLimit(1)
//                                                        }
                                                        
                                                    }//: VSTACK
                                                    .frame(width: 115)
                                                })//: BUTTON
                                            }//: LOOP
                                        }//: HSTACK
                                        .padding(.horizontal)
                                    }//: SCROLLVIEW
                                }//: SECTION
                                
                                
                                SectionView(title: "Categories") {
                                    LazyVGrid(
                                        columns:[GridItem(.adaptive(minimum: geo.frame(in: .global).width / 3))], alignment: .leading) {
                                            ForEach(Category.allCategories, id: \.title) { category in
                                                NavigationLink(destination: CategoryView(category: category)) {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .foregroundColor(Color(.secondarySystemBackground))
                                                        .frame(height: 120)
                                                        .overlay(alignment: .topLeading) {
                                                            VStack(alignment: .leading, spacing: 6) {
                                                                Text(category.title)
                                                                    .fontWeight(.bold)
                                                                    .foregroundColor(Color(.label))
                                                                Text(category.description)
                                                                    .multilineTextAlignment(.leading)
                                                                    .font(.system(size: 14))
                                                                    .foregroundColor(Color(.secondaryLabel))
                                                            }//: VSTACK
                                                            .padding(.all)
                                                        }//: OVERLAY
                                                }//: NAVIGATIONLINK
                                            }//: LOOP
                                        }//: LAZYVGRID
                                        .padding(.horizontal)
                                }//: SECTIONVIEW
                            }//: VSTACK
                            .padding(.vertical, K.topSafeArea + 26)
                            .padding(.bottom, 50 + 50)
                        }//: SCROLLVIEW
                    }//: VSTACK
                }//: ZSTACK
                .toolbar(.hidden)
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                
                VStack {
                    HStack {
                        
                        HStack {
                            Image("merce-icon-\(colorScheme == .dark ? "white" : "black")")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                            
                            Text("Merce")
                                .fontWeight(.semibold)
                        }//: HSTACK
                        
                        Spacer()
                        
                        HStack(spacing: 21) {
                            
                            NavigationLink(destination: InboxView()) {
                                Image(systemName: "paperplane")
                                    .foregroundColor(Color(.label))
                            }//: NAVIGATIONLINK
                            
                        }//: HSTACK
                        .font(.system(size: 22))
                        
                    }//: HSTACK
                    .frame(height: 24)
                    .padding(.vertical, 13)
                    .padding(.horizontal)
                    .padding(.top, K.topSafeArea)
                    .background(
                        VisualEffectView(blurEffect: colorScheme == .dark ? .dark : .light)
                            .overlay(
//                                Color.black.opacity(0.65)
                                Color(.systemBackground).opacity(0.6)
                            )
                    )//: BACKGROUND
                    Spacer()
                }//: VSTACK
                .edgesIgnoringSafeArea(.top)
            }//: GEOMETREY READER
        }//: NAVIGATIONVIEW
        .onAppear {
            self.searchVM.fetchAllArtists()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
            .environmentObject(SearchViewModel())
    }
}
