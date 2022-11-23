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
    @Binding var showMusicPlayerModal: Bool
    
    @State private var isPlaying: Bool = false
    @State private var isFavorite: Bool = false
    @State private var isShuffle: Bool = false
    @State private var isRepeated: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentTime: TimeInterval = .zero
    @State private var totalDuration: TimeInterval = .zero
    @State private var isForwardingTime: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("naval")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                    .clipped()
                
                LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                
                VStack {
                    
                    HStack {
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showMusicPlayerModal = false
                            }
                        }, label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
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
                            }//: HSTACK
                            
                        }//: HSTACK
                        
                        // Timer
                        VStack(spacing: 0) {
                            
                            if let player = playerVM.audioPlayer {
                                Slider(value: $currentTime, in: 0...player.duration, onEditingChanged: { isForwarding in
                                    self.isForwardingTime = isForwarding
                                    player.currentTime = currentTime
                                })
                                .tint(.white)
                            }
                            
//                            RoundedRectangle(cornerRadius: 100)
////                                .frame(maxWidth: .infinity, height: 5)
//                                .frame(maxWidth: .infinity, maxHeight: 5)
//                                .opacity(0.3)
//                                .overlay(alignment: .leading) {
//                                    RoundedRectangle(cornerRadius: 100)
//                                        .frame(width: 200)
//                                }
                            
                            HStack {
                                Text("\(getFormatPlayerTime(interval: currentTime))")
                                Spacer()
                                Text("\(getFormatPlayerTime(interval: playerVM.audioPlayer?.duration))")
                            }
                            .font(.footnote)
                        }
                        
                        HStack {
                            
                            // SHUFFLE
                            Button(action: {
                                withAnimation(.none) {
                                    isShuffle.toggle()
                                }
                            }, label: {
                                Image(systemName: "shuffle")
                                    .foregroundColor(isShuffle ? .white : Color(.secondaryLabel))
                                    .font(.system(size: 20, weight: .medium, design: .default))
                            })
                            
                            
                            Spacer()
                            
                            
                            // Back
                            Button(action: {
                                if let player = playerVM.audioPlayer {
                                    player.currentTime = 0.0
                                    currentTime = 0.0
                                }
                            }, label: {
                                Image(systemName: "backward.end.fill")
                                    .font(.system(size: 28, weight: .medium, design: .default))
                            })
                            
                            Spacer()
                            
                            // Play/Pause
                            Button(action: {
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
                                
                            }, label: {
                                Image(systemName: "forward.end.fill")
                                    .font(.system(size: 28, weight: .medium, design: .default))
                            })
                            
                            Spacer()
                            
                            // Loop
                            Button(action: {
                                withAnimation(.none) {
                                    isRepeated.toggle()
                                }
                            }, label: {
                                Image(systemName: "repeat.1")
                                    .foregroundColor(isShuffle ? .white : Color(.secondaryLabel))
                            })
                            .font(.system(size: 20, weight: .medium, design: .default))
                            
                        }//: PLAYER BAR
                    }//: VSTACK
                    
                }//: VSTACK
                .padding(.all, 26)
//                .padding(.top, K.topSafeArea)
                .padding(.bottom, K.bottomSafeArea)
                
            }//: ZSTACK
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
//            .cornerRadius(21)
            .onReceive(timer) { _ in
                if let audioPlayer = playerVM.audioPlayer {
                    if (!isForwardingTime) {
                        self.currentTime = audioPlayer.currentTime
                    }
                }
            }
            
        }//: GEO
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    
    @Namespace private static var namespace
    
    static var previews: some View {
        MusicPlayerView(playerVM: PlayerViewModel(), showMusicPlayerModal: .constant(true))
    }
}
