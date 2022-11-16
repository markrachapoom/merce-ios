//
//  ContentView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
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
        VStack {
            switch (authVM.state) {
                case .signedIn: MainTabVIew()
                case .signedOut: AuthenticationView()
                case .unknown: SplashScreenView()
            }
        }//: VSTACK
        .onAppear {
            withAnimation {
                authVM.addStateDidChangeListener()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
