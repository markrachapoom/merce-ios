//
//  MusicPlayerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI

struct MusicPlayerView: View {
    
    // Init
    @ObservedObject var playerVM: PlayerViewModel
    
    @State private var isPlaying: Bool = false
    @State private var isFavorite: Bool = false
    @State private var isShuffle: Bool = false
    @State private var isRepeated: Bool = false
    
    //    @Binding var translation: CGSize
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
//                Color.black
//                    .overlay {
//                        Image("naval")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .edgesIgnoringSafeArea(.all)
//                            .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
//                    }
//                    .overlay {
                        // Gradient
                        LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
//                    }
//                    .overlay {
                        VStack {
                            
                            // SWIPE BAR
                            HStack(alignment: .top) {
                                Spacer()
                                Capsule()
                                    .frame(width: 40, height: 5)
                                    .foregroundColor(.white.opacity(0.1))
                                Spacer()
                            }//: HSTACK
                            .padding(.top, K.topSafeArea)
                            
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
                                                .font(.system(size: 24))
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
                                                .frame(width: 32, height: 32)
                                                .foregroundColor(.white.opacity(0.1))
                                                .overlay {
                                                    Image(systemName: "ellipsis")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 22))
                                                    //                                                .font(.system(.title2))
                                                }
                                        }//: ELLIPSIS MENU
                                        .onTapGesture {
                                            K.impactOccur()
                                        }//: TAP GESTURE
                                    }//: HSTACK
                                    
                                }//: HSTACK
                                
                                
                                // Timer
                                VStack {
                                    RoundedRectangle(cornerRadius: 100)
                                        .frame(height: 5)
                                        .opacity(0.3)
                                        .overlay(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 200)
                                        }
                                    
                                    //                            HStack {
                                    //                                Text("\(playerVM.audioPlayer.currentTime)")
                                    //                                Spacer()
                                    //                                Text("\(playerVM.audioPlayer.duration)")
                                    //                            }
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
                                        playerVM.togglePlay()
                                    }, label: {
                                        Circle()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(.white.opacity(0.1))
                                            .overlay {
                                                Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
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
                                    
                                }//: PLAYER BAR
                                .padding(.bottom, K.bottomSafeArea)
                            }//: VSTACK
                            
                        }//: VSTACK
//                                        .padding(.bottom, K.bottomSafeArea)
                        .padding(.all, 26)
//                    }
                
            }//: ZSTACK
//            .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
            .foregroundColor(.white)
            .background(.red)
            .preferredColorScheme(.dark)
            .edgesIgnoringSafeArea(.all)
            .cornerRadius(21)
            
        }//: GEO
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    
    @Namespace private static var namespace
    
    static var previews: some View {
        MusicPlayerView(playerVM: PlayerViewModel())
    }
}
