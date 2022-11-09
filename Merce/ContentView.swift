//
//  ContentView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().isOpaque = true
    }
    
    var body: some View {
        HomeView()
            .tabItem {
                Label("Home", systemImage: "house")
            }
//        TabView {
//
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//
//            SearchView()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
//
//            UserView()
//                .tabItem {
//                    Label("Account", systemImage: "person")
//                }
//
//        }//: TABVIEW
//        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
