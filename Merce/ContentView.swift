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
    
    @State private var tabSelection: Int = 1
    
    init() {
//        UITabBar.appearance().backgroundColor = .black
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .black
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                TabView(selection: $tabSelection) {
                    
                    HomeView(showMusicPlayerModal: $showMusicPlayerModal, translation: $translation)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(1)
                    
                    SearchView(showMusicPlayerModal: $showMusicPlayerModal, translation: $translation)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                        .tag(2)
                    
                    UserView(showMusicPlayerModal: $showMusicPlayerModal, translation: $translation)
                        .tabItem {
                            Label("Account", systemImage: "person")
                        }
                        .tag(3)
                    
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
            .onChange(of: tabSelection) { _ in
                K.impactOccur()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
    }
}
