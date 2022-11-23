//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
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
                            VStack(spacing: 32) {
                                
                                SectionView(title: "Recently Played") {
                                    
                                }
                                
                                SectionView(title: "Discover") {
                                    
                                }
                                
                                SectionView(title: "Entrepreneurs") {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 13) {
                                            ForEach(MerceUser.allEntrepreneurs, id: \.username) { entrepreneur in
                                                NavigationLink(destination: ProfileView(user: entrepreneur)) {
                                                    AsyncImage(url: URL(string: entrepreneur.profileImageURL ?? "")) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                    } placeholder: {
                                                        Circle()
                                                            .foregroundColor(.secondaryBackgroundColor)
                                                    }
                                                    .frame(width: 90, height: 90)
                                                    .clipShape(Circle())
                                                }//: NAVIGATIONLINK
                                            }//: LOOP
                                        }//: HSTACK
                                        .padding(.horizontal)
                                    }//: SCROLLVIEW
                                }
                                
                                SectionView(title: "Categories") {
                                    LazyVGrid(
                                        columns:[GridItem(.adaptive(minimum: geo.frame(in: .global).width / 3))], alignment: .leading) {
                                            ForEach(Category.allCategories, id: \.title) { category in
                                                NavigationLink(destination: CategoryView(category: category)) {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .foregroundColor(Color.secondaryBackgroundColor)
                                                        .frame(height: 120)
                                                        .overlay(alignment: .topLeading) {
                                                            VStack(alignment: .leading, spacing: 6) {
                                                                Text(category.title)
                                                                    .fontWeight(.bold)
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
                            Image("merce-icon-white")
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
                            }//: NAVIGATIONLINK
                            
                        }//: HSTACK
                        .font(.system(size: 22))
                        
                    }//: HSTACK
                    .frame(height: 24)
                    .padding(.vertical, 13)
                    .padding(.horizontal)
                    .padding(.top, K.topSafeArea)
                    .background(
                        VisualEffectView(blurEffect: .dark)
                            .overlay(
//                                Color.black.opacity(0.65)
                                Color.black.opacity(0.6)
                            )
                    )//: BACKGROUND
                    Spacer()
                }//: VSTACK
                .edgesIgnoringSafeArea(.top)
            }//: GEOMETREY READER
        }//: NAVIGATIONVIEW
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
    }
}
