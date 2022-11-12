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
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .black
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                TabView(selection: $tabSelection) {
                    
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
//                            Label("Home", systemImage: "house")
                        }
                        .tag(1)
                    
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
//                            Label("Search", systemImage: "magnifyingglass")
                        }
                        .tag(2)
                    
                    BuzzView()
                        .tabItem {
                            Image(systemName: "rectangle.stack.badge.play")
//                            Label("Buzz", systemImage: "rectangle.stack.badge.play")
                        }
                        .tag(3)
                    
                    NotificationView()
                        .tabItem {
                            Image(systemName: "bell")
//                            Label("Notification", systemImage: "bell")
                        }
                        .tag(4)
                    
                    AccountView()
                        .tabItem {
                            Image(systemName: "person")
//                            Label("Account", systemImage: "person")
                        }
                        .tag(5)
                    
                }//: TABVIEW
                .tint(.white)
                
                MusicPlayerView(playerVM: playerVM, showMusicPlayerModal: $showMusicPlayerModal)
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
                
                BottomMusicPlayerView(translation: $translation, showMusicPlayerModal: $showMusicPlayerModal)
                    .padding(.bottom, 48)
                    .ignoresSafeArea(.keyboard)
                    .opacity(tabSelection == 3 ? 0 : 1)
//
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
