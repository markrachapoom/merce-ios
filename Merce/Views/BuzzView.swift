//
//  BuzzView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct BuzzView: View {
    var body: some View {
        GeometryReader { geo in
            TabView {
                ForEach(MerceUser.allEntrepreneurs, id: \.username) { entrepreneur in
                    
                    VStack(spacing: 0) {
                        
                        ZStack {
                            AsyncImage(url: URL(string: entrepreneur.profileImageURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Rectangle()
                                    .foregroundColor(Color.secondaryBackgroundColor)
                            }
                            .frame(width: geo.size.width)
                            .clipped()
                            
                            LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.pink)
                                    Spacer()
                                }
                            }
                            
                        }//: ZSTACK
                        
                        Divider()
                        
                    }
                    .frame(width: geo.size.width)
                    .rotationEffect(.degrees(-90))
//                    VStack(spacing: 0) {
//                        ZStack {
//
//                            AsyncImage(url: URL(string: entrepreneur.profileImageURL ?? "")) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                Rectangle()
//                                    .foregroundColor(Color.secondaryBackgroundColor)
//                            }
//                            .frame(width: geo.size.height)
//                            .frame(width: geo.size.width)
//                            .clipped()
//
//                            LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
//
//                            VStack {
//                                Spacer()
//                                HStack {
//
//                                    Spacer()
//
//                                    VStack {
//                                        Image(systemName: "heart.fill")
//                                            .foregroundColor(.pink)
//                                    }
//
//                                    Spacer()
//
//                                }
//                                .padding(.horizontal)
//                                .padding(.bottom, 50)
//                            }
//
//                        }//: ZSTACK
//
//                        Divider()
//
//                    }//: VSTACK
////                    .frame(width: geo.size.width)
////                    .frame(width: geo.size.width)
//                    .rotationEffect(.degrees(-90))
                }
            }//: TABVIEW
            .rotationEffect(.degrees(90))
            .frame(width: geo.size.height)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(width: geo.size.width)
//            .frame(height: size.height)
        }//: GEOMETRY READER
//        .edgesIgnoringSafeArea(.top)
    }
}

struct BuzzView_Previews: PreviewProvider {
    static var previews: some View {
        BuzzView()
            .preferredColorScheme(.dark)
//            .edgesIgnoringSafeArea(.all)
    }
}
