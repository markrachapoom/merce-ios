//
//  SplashScreenView.swift
//  
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            
            Color.black
            
            Image("merce-icon-white")
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
