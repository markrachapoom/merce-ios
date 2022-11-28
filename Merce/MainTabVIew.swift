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
    @State private var canOpenMusicPlayerModal: Bool = true
    
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
                        
                        if (playerVM.currentSong != nil) {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    self.showMusicPlayerModal = true
                                    self.canOpenMusicPlayerModal = false
                                }
                            }, label: {
                                BottomMusicPlayerView()
                                    .opacity(tabSelection == 3 ? 0 : 1)
                            })//: BUTTON
                            .disabled(!canOpenMusicPlayerModal)
                        }
//                            .offset(y: tabSelection == 3 ? 200 : 0)
                        
                        HStack(spacing: 0) {
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 1, iconName: "house")
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 2, iconName: "magnifyingglass", canFilled: false)
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 3, iconName: "rectangle.stack.badge.play")
                                .onChange(of: tabSelection) { newTabSelection in
                                    if (newTabSelection == 3) {
                                        playerVM.pause()
                                    }
                                }
                            
                            TabBarButton(tabSelection: $tabSelection, tag: 4, iconName: "bell")
                            
//                            TabBarButton(tabSelection: $tabSelection, tag: 5, iconName: "person")
                            
                            Button(action: {
                                withAnimation(.none) {
                                    self.tabSelection = 5
                                }
                            }, label: {
                                HStack {
                                    Spacer()
                                    
                                    AsyncImage(url: URL(string: authVM.currentMerceUser?.profileImageURL ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 26, height: 26)
                                            .clipShape(Circle())
                                            .background(
                                                Circle()
                                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                                    .frame(width: 38, height: 28)
                                                    .foregroundColor(tabSelection == 5 ? Color(.label) : .clear)
                                            )//: BACKGROUND
                                    } placeholder: {
                                        Image(systemName: "person")
                                            .font(.system(size: 22, weight: tabSelection == 2 ? .bold : .medium))
                                            .foregroundColor(Color(.label))
                                            .frame(width: 26, height: 26)
                                    }//: ASYNCIMAGE
                                    Spacer()
                                }//: HSTACK
                                .padding(.all)
                            })//: BUTTON
                            
                        }//: HSTACK
                        .frame(height: K.bottomTabBarHeight)
//                        .background(Color(.systemBackground))
                        .background(
                            LinearGradient(colors: [.black, .black.opacity(0.75)], startPoint: .bottom, endPoint: .top)
                        )//: BACKGROUND
                    }//: VSTACK
                }//: VSTACK
                .ignoresSafeArea(.keyboard)
            }//: ZSTACK
            .sheet(isPresented: $showMusicPlayerModal, onDismiss: {
                self.canOpenMusicPlayerModal = true
            }, content: {
                MusicPlayerView(playerVM: playerVM, showMusicPlayerModal: $showMusicPlayerModal)
//                    .presentationDetents([.height(geo.frame(in: .global).height)])
                    .presentationDetents([.large])
            })
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
//            withAnimation(.easeInOut(duration: 0.2)) {
            withAnimation(.none) {
                self.tabSelection = tag
            }
        }, label: {
            HStack {
                Spacer()
                Image(systemName: "\(iconName)\((canFilled && (tabSelection == tag)) ? ".fill" : "")")
                    .font(.system(size: 22, weight: tabSelection == 2 ? .bold : .medium))
                    .foregroundColor(Color(.label))
                    .frame(width: 24, height: 24)
                Spacer()
            }//: HSTACK
            .padding(.all)
        })//: BUTTON
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabVIew()
            .environmentObject(PlayerViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
