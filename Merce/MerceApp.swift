//
//  MerceApp.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI
import Firebase

@main
struct MerceApp: App {
    
    // Use Firebase library to configure APIs
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(PlayerViewModel())
                .environmentObject(AuthenticationViewModel())
                .environmentObject(SearchViewModel())
        }
    }
}
