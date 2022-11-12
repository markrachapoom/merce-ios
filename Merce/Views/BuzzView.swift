//
//  BuzzView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct BuzzView: View {
    
    @State private var isFavorite: Bool = false
    
    @State private var tabSelection: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $tabSelection) {
                ForEach(Array(zip(MerceUser.allEntrepreneurs.indices, MerceUser.allEntrepreneurs)), id: \.0) { index, buzz in
                    VStack(spacing: 0) {
                        
                        ZStack {
                            AsyncImage(url: URL(string: buzz.profileImageURL ?? "")) { image in
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
                                
                                HStack(alignment: .bottom, spacing: 13) {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading, spacing: 13) {
                                            HStack(spacing: 13) {
                                                
                                                AsyncImage(url: URL(string: buzz.profileImageURL ?? "")) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                } placeholder: {
                                                    Circle()
                                                        .foregroundColor(.secondaryBackgroundColor)
                                                }
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                                
                                                VStack(alignment: .leading) {
                                                    Text("\(buzz.name ?? "")")
                                                        .font(.system(size: K.fontSize, weight: .medium, design: .default))
                                                    
                                                    Text("@\(buzz.username ?? "")")
                                                        .foregroundColor(Color(.secondaryLabel))
                                                        .font(.system(size: K.fontSize, weight: .regular, design: .default))
                                                }
                                                
                                                Button(action: {
                                                    K.impactOccur()
                                                }, label: {
                                                    Text("Follow")
                                                        .padding(.horizontal, 11)
                                                        .padding(.vertical, 6)
                                                        .font(.system(size: 14, weight: .medium, design: .default))
                                                        .background(
                                                            Capsule()
                                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                                .foregroundColor(Color(.separator))
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
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(spacing: 21) {
                                        
                                        VStack(spacing: 6) {
                                            Button(action: {
                                                K.impactOccur()
                                                withAnimation(.easeInOut(duration: 0.1)) {
                                                    isFavorite.toggle()
                                                }
                                            }, label: {
                                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                                    .foregroundColor(isFavorite ? .pink : .white)
                                                    .font(.system(size: 28, weight: .regular, design: .default))
                                            })
                                            
                                            Button(action: {}, label: {
                                                Text("30K")
                                                    .font(.system(.footnote, design: .default, weight: .medium))
                                            })
                                            
                                        }//: VSTACK
                                        
                                        VStack(spacing: 6) {
                                            Button(action: {
                                                K.impactOccur()
                                            }, label: {
                                                Image(systemName: "bubble.left")
                                            })
                                            
                                            Button(action: {}, label: {
                                                Text("1.4K")
                                                    .font(.system(.footnote, design: .default, weight: .medium))
                                            })
                                        }//: VSTACK
                                        
                                        
                                        VStack(spacing: 6) {
                                            Button(action: {
                                                K.impactOccur()
                                            }, label: {
                                                Image(systemName: "paperplane")
                                            })
                                            
                                            Button(action: {}, label: {
                                                Text("Share")
                                                    .font(.system(.footnote, design: .default, weight: .medium))
                                            })
                                            
                                        }//: VSTACK
                                        
                                        
                                        VStack(spacing: 6) {
                                            Button(action: {
                                                K.impactOccur()
                                            }, label: {
                                                Image(systemName: "bookmark")
                                            })
                                            
                                            Button(action: {}, label: {
                                                Text("Save")
                                                    .font(.system(.footnote, design: .default, weight: .medium))
                                            })
                                        }//: VSTACK
                                        
                                        Button(action: {}, label: {
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
                                    
                                }//: HSTACK
                                .padding(.all)
                            }
                            
                        }//: ZSTACK
                        
                        Divider()
                        
                    }
                    .frame(width: geo.size.width)
                    .rotationEffect(.degrees(-90))
                }//: LOOP
            }//: TABVIEW
            .rotationEffect(.degrees(90))
            .frame(width: geo.size.height)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(width: geo.size.width)
            .onChange(of: tabSelection) { _ in
                K.impactOccur()
            }
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
