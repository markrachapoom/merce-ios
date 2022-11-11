//
//  HomeView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var playerVM: PlayerViewModel
    
    @Binding var showMusicPlayerModal: Bool
    @Binding var translation: CGSize
//    @State private var translation: CGSize = .zero
//    @State private var showMusicPlayerModal: Bool = false
    
    @Namespace private var musicPlayerNamespace
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack {
                    
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))], spacing: 13) {
//                            ForEach(1..<10, id: \.self) { number in
//                                Button(action: {
//                                    K.impactOccur()
//                                }, label: {
//                                    RoundedRectangle(cornerRadius: 0)
//                                        .foregroundColor(Color(.secondarySystemBackground))
//                                        .frame(height: 120)
//                                })
//                            }
//                        }
//                    }
                    
                    ScrollView {
                        Color.black
                            .frame(height: 10000)
                    }
                    
                    Spacer()
                    
                }//: VSTACK
                
                BottomMusicPlayerView(translation: $translation, showMusicPlayerModal: $showMusicPlayerModal)
                
            }//: ZSTACK
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMusicPlayerModal: .constant(false), translation: .constant(.zero))
            .preferredColorScheme(.dark)
            .environmentObject(PlayerViewModel())
    }
}
