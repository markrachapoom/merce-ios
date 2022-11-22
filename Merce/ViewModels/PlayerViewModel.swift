//
//  PlayerViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/09.
//

import Foundation
import SwiftUI
import AVKit

class PlayerViewModel: ObservableObject {
    
    @Published var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying: Bool = false
    
//    @Published var currentTime: TimeInterval = .zero
    
    init() {
        let musicPath = Bundle.main.path(forResource: "society-always-wants-new-things", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: musicPath!))
    }
    
    var currentTime: TimeInterval {
        audioPlayer?.currentTime ?? 0.0
    }

    
    func togglePlay() {
        if (isPlaying) {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        if let player = audioPlayer {
            withAnimation(.none) {
                player.play()
                isPlaying = true
            }
        }
    }
    
    func pause() {
        if let player = audioPlayer {
            withAnimation(.none) {
                player.pause()
                isPlaying = false
            }
        }
    }
}
