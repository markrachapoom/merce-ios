//
//  BottomMusicPlayerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct BottomMusicPlayerView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    var body: some View {
            VStack(spacing: 0) {
                
                HStack {
                    
                    HStack {
                        
                        Image("naval-pink")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(6)
                        
                        VStack(alignment: .leading) {
                            
                            Text("Society Always Wants New Things")
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
                            .foregroundColor(.white.opacity(0.1))
                            .overlay {
                                Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }//: OVERLAY
                    })//: BUTTON
                    
                }//: HSTACK
                .padding(.all, 11)
                .background(
                    VisualEffectView(blurEffect: .systemUltraThinMaterial)
                        .background(Color.pink.opacity(0.25))
                        .cornerRadius(13)
                )//: BACKGROUND
                .padding(.horizontal, 6)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct BottomMusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomMusicPlayerView()
            .environmentObject(PlayerViewModel())
    }
}
