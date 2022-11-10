//
//  ContentView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    @State private var translation: CGSize = .zero
    @State private var showMusicPlayerModal: Bool = false
    
    init() {
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().isOpaque = true
    }
    
    var body: some View {
//        HomeView()
//            .tabItem {
//                Label("Home", systemImage: "house")
//            }
        GeometryReader { geo in
            ZStack {
                TabView {
                    
                    HomeView(showMusicPlayerModal: $showMusicPlayerModal, translation: $translation)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    SearchView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    
                    UserView()
                        .tabItem {
                            Label("Account", systemImage: "person")
                        }
                    
                }//: TABVIEW
                .tint(.white)
                
                MusicPlayerView(playerVM: playerVM)
                    .offset(y: translation.height)
                    .offset(y: showMusicPlayerModal ? 0 : geo.frame(in: .global).height)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.easeInOut(duration: 0.03)) {
                                    if (value.translation.height >= 0) {
                                        self.translation = value.translation
                                    }
                                }
                            })
                            .onEnded({ value in
                                if (value.translation.height > 100) {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.showMusicPlayerModal = false
                                    }
                                } else {
                                    withAnimation {
                                        self.translation = .zero
                                    }
                                }
                            })
                    )//: GESTURE
                    .opacity(showMusicPlayerModal ? 1 : 0)
                    .edgesIgnoringSafeArea(.all)
                
            }//: ZSTACK
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
