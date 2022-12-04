//
//  BottomMusicPlayerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct BottomMusicPlayerView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    var body: some View {
            VStack(spacing: 0) {
                
                HStack {
                    
                    HStack {
                        
                        AsyncImage(url: URL(string: playerVM.currentSong?.artwork?.url ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .foregroundColor(Color(.secondarySystemBackground))
                        }
                        .frame(width: 40, height: 40)
                        .cornerRadius(6)
                        
                        VStack(alignment: .leading) {
                            
//                            Text("Society Always Wants New Things")
                            Text(playerVM.currentSong?.title ?? "Unknown")
                                .foregroundColor(Color(.label))
                                .font(.system(size: K.fontSize))
                                .fontWeight(.medium)
                                .lineLimit(1)
                            
                            Text("Akira The Don, Naval Ravikant")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: K.fontSize))
                                .lineLimit(1)
                            
                        }//: VSTACK
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.none) {
                            withAnimation(.none) {
                                playerVM.togglePlay()
                            }
                        }
                    }, label: {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.clear)
                            .background(
                                VisualEffectView(blurEffect: .light)
                                    .cornerRadius(100)
                            )
//                            .foregroundColor(.white.opacity(colorScheme == .dark ? 0.2 : 0.65))
                    
//                            .foregroundColor(Color(.systemFill))
                            .overlay {
                                Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title2)
                                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.75) : .black)
                                    .shadow()
//                                    .foregroundColor(.white)
                            }//: OVERLAY
                    })//: BUTTON
                    
                }//: HSTACK
                .padding(.all, 11)
                .background(
                    VisualEffectView(blurEffect: .systemUltraThinMaterial)
//                        .background(Color.pink.opacity(0.3))
                        .cornerRadius(13)
                )//: BACKGROUND
                .padding(.horizontal, 6)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct BottomMusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Color.white
                BottomMusicPlayerView()
            }

            ZStack {
                Color.black
                BottomMusicPlayerView()
                    .colorScheme(.dark)
            }
        }
        .environmentObject(PlayerViewModel())
        .previewLayout(.sizeThatFits)
    }
}
