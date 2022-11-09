//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct HomeView: View {
    @State private var translation: CGSize = .zero
    @State private var showMusicPlayerModal: Bool = false
    
    @State private var isPlaying: Bool = false
    
    @Namespace private var musicPlayer
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack {
                    Text("Home View")
                    
                    Spacer()
                    
                    Button(action: {
                        K.impactOccur()
                        withAnimation {
                            self.translation = .zero
                            self.showMusicPlayerModal = true
                        }
                    }, label: {
                            
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
                                withAnimation(.none) {
                                    K.impactOccur()
                                    isPlaying.toggle()
                                }
                            }, label: {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white.opacity(0.1))
                                    .overlay {
                                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                            })
                            
                        }//: HSTACK
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.secondaryBackgroundColor)
                    })
                    .matchedGeometryEffect(id: "MusicPlayer", in: musicPlayer)
                    
                }//: VSTACK
            }//: ZSTACK
            .sheet(isPresented: $showMusicPlayerModal) {
                MusicPlayerView(translation: .constant(.zero))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
