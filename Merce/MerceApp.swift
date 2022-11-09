//
//  MerceApp.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/08.
//

import SwiftUI

@main
struct MerceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(PlayerViewModel())
        }
    }
}
