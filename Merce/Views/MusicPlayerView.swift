//
//  MusicPlayerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI

struct MusicPlayerView: View {
    
    @State private var isPlaying: Bool = false
    @State private var isFavorite: Bool = false
    @State private var isShuffle: Bool = false
    @State private var isRepeated: Bool = false
    
    @Binding var translation: CGSize
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.black
                    .overlay {
                        Image("naval")
                            .resizable()
                            .scaledToFill()
                    }
                    .overlay {
                        // Gradient
                        LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                    }
                
                VStack {
                    
                    Spacer()
                    
                    VStack(spacing: 32) {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text("Society Always Wants New Things")
                                    .font(.system(.title3, design: .default, weight: .bold))
                                    .lineLimit(1)
                                
                                Text("Akira The Don, Naval Ravikant")
                                    .foregroundColor(Color(.secondaryLabel))
                                
                            }//: VSTACK
                            
                            Spacer()
                            
                            HStack(spacing: 13) {
                                
                                Button(action: {
                                    K.impactOccur()
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        isFavorite.toggle()
                                    }
                                }, label: {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite ? .pink : Color(.label))
                                        .font(.system(.title2))
                                })
                                
                                Menu {
                                    
                                    Button(action: {}, label: {
                                        Label("Add to queue", systemImage: "text.append")
                                    })
                                    
                                    Button(action: {}, label: {
                                        Label("Add to Playlist", systemImage: "text.badge.plus")
                                    })
                                    
                                } label: {
                                    Circle()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.white.opacity(0.1))
                                        .overlay {
                                            Image(systemName: "ellipsis")
                                                .foregroundColor(.white)
                                                .font(.system(.title3))
                                        }
                                }//: ELLIPSIS MENU
                                .onTapGesture {
                                    K.impactOccur()
                                }
                            }
                            
                        }//: HSTACK
                        
                        RoundedRectangle(cornerRadius: 100)
                            .frame(height: 5)
                            .opacity(0.3)
                            .overlay(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 100)
                                    .frame(width: 200)
                            }
                        
                        HStack {
                            
                            // SHUFFLE
                            Button(action: {
                                K.impactOccur()
                                withAnimation(.none) {
                                    isShuffle.toggle()
                                }
                            }, label: {
                                Image(systemName: "shuffle")
                                    .foregroundColor(isShuffle ? .accentColor : Color(.label))
                            })
                            
                            
                            Spacer()
                            
                            
                            // Back
                            Button(action: {
                                K.impactOccur()
                            }, label: {
                                Image(systemName: "backward.end.fill")
                                    .font(.system(size: 28, weight: .medium, design: .default))
                            })
                            
                            Spacer()
                            
                            // Play/Pause
                            Button(action: {
                                K.impactOccur()
                                withAnimation(.none) {
                                    isPlaying.toggle()
                                }
                            }, label: {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white.opacity(0.1))
                                    .overlay {
                                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                            .font(.system(size: 32, weight: .medium, design: .default))
                                    }
                            })
                            
                            Spacer()
                            
                            // Forward
                            Button(action: {
                                K.impactOccur()
                            }, label: {
                                Image(systemName: "forward.end.fill")
                                    .font(.system(size: 28, weight: .medium, design: .default))
                            })
                            
                            Spacer()
                            
                            // Loop
                            Button(action: {
                                K.impactOccur()
                                withAnimation(.none) {
                                    isRepeated.toggle()
                                }
                            }, label: {
                                Image(systemName: "repeat.1")
                                    .foregroundColor(isRepeated ? .accentColor : Color(.label))
                            })
                            
                        }//: TOOLBAR
                        .padding(.bottom, K.bottomSafeArea)
                    }//: VSTACK
                    
                }//: VSTACK
//                .padding(.bottom, K.bottomSafeArea)
                .padding(.all, 26)
                
            }//: ZSTACK
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
            .edgesIgnoringSafeArea(.bottom)
            .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
            
        }//: GEO
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView(translation: .constant(.zero))
    }
}
