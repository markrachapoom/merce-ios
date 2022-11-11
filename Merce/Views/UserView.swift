//
//  UserView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct UserView: View {
    
    @Binding var showMusicPlayerModal: Bool
    @Binding var translation: CGSize
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            
            BottomMusicPlayerView(translation: $translation, showMusicPlayerModal: $showMusicPlayerModal)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(showMusicPlayerModal: .constant(false), translation: .constant(.zero))
    }
}
