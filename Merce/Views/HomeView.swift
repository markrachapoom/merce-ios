//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    @Binding var showMusicPlayerModal: Bool
    @Binding var translation: CGSize
//    @State private var translation: CGSize = .zero
//    @State private var showMusicPlayerModal: Bool = false
    
    @Namespace private var musicPlayerNamespace
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack(spacing: 0) {
                    
                    List(0..<100, id: \.self) { number in
                        HStack {
                            Text("\(number)")
                            Spacer()
                        }
                        .padding(.all)
                    }
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        K.impactOccur()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            translation = .zero
                            showMusicPlayerModal = true
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
                        .background(Color.secondaryBackgroundColor)
                    })//: BUTTON
                    .opacity(showMusicPlayerModal ? 0 : 1)
                    .offset(y: showMusicPlayerModal ? 150 : 0)
                    
                }//: VSTACK
                
            }//: ZSTACK
//            .edgesIgnoringSafeArea(.all)
//            .sheet(isPresented: $showMusicPlayerModal) {
//                MusicPlayerView(playerVM: playerVM)
//            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMusicPlayerModal: .constant(false), translation: .constant(.zero))
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
    }
}
