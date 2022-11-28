//
//  SplashScreenView.swift
//  
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import SwiftUI

struct SplashScreenView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            
            Color(.systemBackground)
            
            Image("merce-icon-\(colorScheme == .dark ? "white" : "black")")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
        }//: ZSTACK
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(SearchViewModel())
            .environmentObject(PlayerViewModel())
    }
}
