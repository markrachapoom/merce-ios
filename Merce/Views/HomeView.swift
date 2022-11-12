//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    @Binding var showMusicPlayerModal: Bool
    @Binding var translation: CGSize
//    @State private var translation: CGSize = .zero
//    @State private var showMusicPlayerModal: Bool = false
    
    @Namespace private var musicPlayerNamespace
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 32) {
                            SectionView(title: "Entrepreneurs") {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 13) {
                                        ForEach(MerceUser.allEntrepreneurs, id: \.username) { entrepreneur in
                                            NavigationLink(destination: ProfileView(userData: entrepreneur)) {
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
                                            }
                                        }//: LOOP
                                    }//: HSTACK
                                    .padding(.horizontal)
                                }//: SCROLLVIEW
                            }
                            
                            SectionView(title: "Categories") {
                                LazyVGrid(
                                    columns:[GridItem(.adaptive(minimum: geo.frame(in: .global).width / 3))], alignment: .leading) {
                                        ForEach(Category.allCategories, id: \.title) { category in
                                        Button(action: {
                                            K.impactOccur()
                                        }, label: {
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(Color.secondaryBackgroundColor)
                                                .frame(height: 120)
                                                .overlay(alignment: .topLeading) {
                                                    VStack(alignment: .leading, spacing: 6) {
                                                        Text(category.title)
                                                            .fontWeight(.bold)
                                                        Text(category.description)
                                                            .multilineTextAlignment(.leading)
//                                                                .lineLimit(2)
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color(.secondaryLabel))
                                                    }
                                                    .padding(.all)
                                                }
                                        })
                                    }
                                }//: LAZYVGRID
                                .padding(.horizontal)
                            }//: SECTIONVIEW
                        }//: VSTACK
                        .padding(.vertical, 26)
                        .padding(.bottom, 50 + 50)
                        
                    }//: SCROLLVIEW
                    
                }//: ZSTACK
            }
        }//: NAVIGATIONVIEW
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMusicPlayerModal: .constant(false), translation: .constant(.zero))
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
    }
}
