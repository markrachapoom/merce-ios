//
//  BuzzView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI
import AVKit

struct BuzzView: View {
    
    @State private var isFavorite: Bool = false
    @State private var isSaved: Bool = false
    
    @State private var tabSelection: Int = 0
    
    let buzzConerRadius: CGFloat = 21
    
    @State private var isFollowed: Bool = false
    
    @State private var buzzes = MediaFile.allMediaFiles.map { item -> Buzz in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Buzz(player: player, mediaFile: item)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                TabView(selection: $tabSelection) {
                    
//                    ForEach(Array(zip(buzzes.indices, buzzes)), id: \.0) { index, $buzz in
                    ForEach(buzzes, id: \.id) { buzz in
                        
                        ZStack(alignment: .top) {
                            
                            VStack {
                                BuzzPlayer(buzz: buzz)
//                                AsyncImage(url: URL(string: buzz?.profileImageURL ?? "")) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                } placeholder: {
//                                    Rectangle()
//                                        .foregroundColor(Color.secondaryBackgroundColor)
//                                }
                                .frame(width: geo.size.width, height: geo.size.height - K.bottomTabBarHeight)
//                                .overlay {
//                                    Color.lightBlue.opacity(0.3)
//                                }
                                //                            .frame(width: geo.size.width)
                                .clipped()
                                .overlay {
                                    VStack {
                                        Spacer()
//                                        LinearGradient(colors: [.red, .black.opacity(0.8), .black.opacity(0)], startPoint: .bottom, endPoint: .top)
                                        LinearGradient(colors: [.black.opacity(0.8), .black.opacity(0)], startPoint: .bottom, endPoint: .top)
                                            .frame(maxHeight: 150)
                                    }//: VSTACK
                                }//: OVERLAY
                                .overlay {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack(alignment: .bottom, spacing: 13) {
                                            
                                            VStack {
                                                
                                                Spacer()
                                                
                                                VStack(alignment: .leading, spacing: 13) {
                                                    HStack(spacing: 13) {
                                                        
//                                                        NavigationLink(destination: ProfileView(user: buzz, isProfileOwner: false)) {
//                                                            HStack(spacing: 13) {
//                                                                AsyncImage(url: URL(string: buzz.profileImageURL ?? "")) { image in
//                                                                    image
//                                                                        .resizable()
//                                                                        .scaledToFill()
//                                                                } placeholder: {
//                                                                    Circle()
//                                                                        .foregroundColor(.secondaryBackgroundColor)
//                                                                }
//                                                                .frame(width: 40, height: 40)
//                                                                .clipShape(Circle())
//                                                                
//                                                                VStack(alignment: .leading) {
//                                                                    Text("\(buzz.givenName ?? "")")
//                                                                        .font(.system(size: K.fontSize, weight: .medium, design: .default))
//                                                                    
//                                                                    Text("@\(buzz.username ?? "")")
//                                                                        .foregroundColor(Color(.secondaryLabel))
//                                                                        .font(.system(size: K.fontSize, weight: .regular, design: .default))
//                                                                }
//                                                            }//: HSTACK
//                                                        }//: NAVIGATIONLINK
                                                        
                                                        Button(action: {
                                                            withAnimation(.none) {
                                                                self.isFollowed.toggle()
                                                            }
                                                        }, label: {
                                                            Text(isFollowed ? "Followed" : "Follow")
                                                                .frame(width: 78, height: 28)
                                                                .font(.system(size: K.fontSize - 1, weight: .semibold, design: .default))
                                                                .background(
                                                                    Capsule()
                                                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                                                        .foregroundColor(isFollowed ? .white.opacity(0.65) : .white.opacity(0.3))
                                                                )//: BACKGROUND
                                                        })//: BUTTON
                                                        
                                                    }//: HSTACK
                                                    
                                                    Text("This is description and thing and ting and things and thing")
                                                        .font(.system(size: K.fontSize, weight: .regular, design: .default))
                                                        .lineLimit(1)
                                                    
                                                    HStack {
                                                        Image(systemName: "music.note")
                                                        Text("Society Always Wants New Things - Akira The Don, Naval Ravikant")
                                                            .font(.system(size: K.fontSize, weight: .regular, design: .default))
                                                            .lineLimit(1)
                                                    }//: HSTACK
                                                    
                                                }//: VSTACK
                                            }//: VSTACK
                                            
                                            Spacer()
                                            
                                            VStack(spacing: 21) {
                                                
                                                VStack(spacing: 6) {
                                                    Button(action: {
                                                        withAnimation(.easeInOut(duration: 0.1)) {
                                                            isFavorite.toggle()
                                                        }
                                                    }, label: {
                                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                                            .foregroundColor(isFavorite ? .pink : .white)
                                                            .font(.system(size: 28, weight: .regular, design: .default))
                                                    })
                                                    
                                                    Button(action: {
                                                        
                                                    }, label: {
                                                        Text("30K")
                                                            .font(.system(size: K.fontSize - 2, weight: .semibold, design: .default))
                                                    })
                                                    
                                                }//: VSTACK
                                                
                                                VStack(spacing: 6) {
                                                    Button(action: {
                                                        
                                                    }, label: {
                                                        Image(systemName: "bubble.left")
                                                    })
                                                    
                                                    Button(action: {}, label: {
                                                        Text("1.4K")
                                                            .font(.system(size: K.fontSize - 2, weight: .semibold, design: .default))
                                                    })
                                                }//: VSTACK
                                                
                                                
                                                Button(action: {
                                                    
                                                }, label: {
                                                    VStack(spacing: 6) {
                                                        Image(systemName: "paperplane")
                                                        
                                                        Text("Share")
                                                            .font(.system(size: K.fontSize - 2, weight: .semibold, design: .default))
                                                    }
                                                })
                                                
                                                
                                                
                                                Button(action: {
                                                    withAnimation(.easeInOut(duration: 0.1)) {
                                                        isSaved.toggle()
                                                    }
                                                }, label: {
                                                    VStack(spacing: 6) {
                                                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                                        
                                                        Text("Save")
                                                            .font(.system(size: K.fontSize - 2, weight: .semibold, design: .default))
                                                    }
                                                })
                                                
                                                Button(action: {
                                                    
                                                }, label: {
                                                    Image("naval-pink")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 32, height: 32)
                                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                                })
                                                
                                            }//: VSTACK
                                            .foregroundColor(Color(.white))
                                            .font(.system(size: 24, weight: .regular, design: .default))
                                            .font(.title)
                                            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
                                            
                                        }//: HSTACK
                                        .padding(.all)
                                        .background(.clear)
                                        
                                    }//: VSTACK
                                }//: OVERLAY
                            }
                            .cornerRadius(buzzConerRadius)
                            .padding(.bottom, K.bottomTabBarHeight)
                                
                                
                            
                        }//: ZSTACK
                        .cornerRadius(buzzConerRadius)
                        .frame(width: geo.size.width)
                        .rotationEffect(.degrees(-90))
                    }//: FOREACH
                }//: TABVIEW
                .rotationEffect(.degrees(90))
                .frame(width: geo.size.height)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(width: geo.size.width)
                .cornerRadius(buzzConerRadius)
            }//: GEOMETRYREADER
        }//: NAVIGATIONVIEW
    }
}

struct BuzzView_Previews: PreviewProvider {
    static var previews: some View {
        BuzzView()
            .preferredColorScheme(.dark)
        //            .edgesIgnoringSafeArea(.all)
    }
}
