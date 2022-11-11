//
//  BottomMusicPlayerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct BottomMusicPlayerView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    @Binding var translation: CGSize
    @Binding var showMusicPlayerModal: Bool
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Button(action: {
                K.impactOccur()
                withAnimation(.easeInOut(duration: 0.3)) {
                    translation = .zero
                    showMusicPlayerModal = true
                }
            }, label: {
                VStack(spacing: 0) {
                    HStack {
                        
                        HStack {
                            
                            Image("naval-cover")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                            
                            VStack(alignment: .leading) {
                                
                                Text("Society Always Wants New Things")
                                    .foregroundColor(Color(.label))
                                    .font(.callout)
                                    .lineLimit(1)
                                
                                Text("Akira The Don, Naval Ravikant")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.subheadline)
                                    .lineLimit(1)
                                
                            }//: VSTACK
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            K.impactOccur()
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
                                }
                        })
                        
                    }//: HSTACK
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    Divider()
                }
            })//: BUTTON
        }
        .opacity(showMusicPlayerModal ? 0 : 1)
        .offset(y: showMusicPlayerModal ? 150 : 0)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct BottomMusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomMusicPlayerView(translation: .constant(.zero), showMusicPlayerModal: .constant(false))
            .environmentObject(PlayerViewModel())
    }
}
