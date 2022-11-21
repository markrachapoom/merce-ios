//
//  BuzzPlayer.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/21.
//

import SwiftUI

struct BuzzPlayer: View {
    
//    @Binding var buzz: Buzz
    var buzz: Buzz
    
    var body: some View {
        ZStack {
            if let buzzPlayer = buzz.player {
                BuzzVideoPlayer(player: buzzPlayer)
                    .onTapGesture {
                        let isPlaying = (buzzPlayer.rate != 0) && (buzzPlayer.error == nil)
                        if (isPlaying) {
                            buzzPlayer.pause()
                        } else {
//                            buzzPlayer.play()
                        }
                    }
            }
        }
        .onAppear {
//            buzz.player?.play()
            buzz.player?.pause()
        }
        .onDisappear {
//            buzz.player?.seek(to: .zero)
            buzz.player?.pause()
        }
    }
}

struct BuzzPlayer_Previews: PreviewProvider {
    static var previews: some View {
//        BuzzPlayer(buzz: .constant(Buzz.init(mediaFile: MediaFile.init(url: "", title: ""))))
        BuzzPlayer(buzz: Buzz(mediaFile: MediaFile.init(url: "", title: "")))
    }
}
