//
//  MainTabVIew.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import SwiftUI

struct MainTabVIew: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
    @State private var translation: CGSize = .zero
    @State private var showMusicPlayerModal: Bool = false
    
    @State private var tabSelection: Int = 1
    
    @State private var showLoginScreen: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                TabView(selection: $tabSelection) {
                    
                    HomeView()
                        .tag(1)
                    
                    SearchView()
                        .tag(2)
                    
                    BuzzView()
                        .tag(3)
                    
                    NotificationView()
                        .tag(4)
                    
                    AccountView()
                        .tag(5)
                    
                }//: TABVIEW
                .tint(.white)
                
                VStack {
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        
                        BottomMusicPlayerView(translation: $translation, showMusicPlayerModal: $showMusicPlayerModal)
                            .offset(y: tabSelection == 3 ? 200 : 0)
                            .opacity(tabSelection == 3 ? 0 : 1)
                        
                        HStack(spacing: 0) {
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 1, iconName: "house")
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 2, iconName: "magnifyingglass", canFilled: false)
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 3, iconName: "rectangle.stack.badge.play")
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 4, iconName: "bell")
                            
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 5, iconName: "person")
                            
                        }//: HSTACK
                        .frame(height: K.bottomTabBarHeight)
                        .background(Color(.systemBackground))
//                        .background(LinearGradient(colors: [.black, .black.opacity(0)], startPoint: .bottom, endPoint: .top))
                        
                    }//: VSTACK
                    
                }//: VSTACK
                .ignoresSafeArea(.keyboard)
                
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
                
            }//: ZSTACK
            .onChange(of: tabSelection) { _ in
                K.impactOccur()
            }//: ONCHANGE
        }
    }
}

struct TabBarButton: View {
    
    @Binding var tabSelection: Int
    let tag: Int
    let iconName: String
    let canFilled: Bool
    
    init(tabSelection: Binding<Int>, tag: Int, iconName: String, canFilled: Bool = true) {
        self._tabSelection = tabSelection
        self.tag = tag
        self.iconName = iconName
        self.canFilled = canFilled
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.tabSelection = tag
            }
        }, label: {
            HStack {
                Spacer()
                Image(systemName: "\(iconName)\((canFilled && (tabSelection == tag)) ? ".fill" : "")")
                    .font(.system(size: 20.5, weight: tabSelection == 2 ? .bold : .medium))
                    .foregroundColor(Color(.label))
                    .frame(width: 24, height: 24)
                Spacer()
            }//: HSTACK
            .padding(.all)
        })
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
    }
}
