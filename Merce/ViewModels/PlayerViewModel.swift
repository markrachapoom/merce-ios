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
    
    @Published var audioAVPlayer: AVPlayer?
    @Published var currentSong: MerceSong?
    
    @Published var isPlaying: Bool = false
    
//    @Published var currentTime: TimeInterval = .zero
    
    init() {
        // Set AvAudio or fetch latest song to play when the app launched
    }
    
    func playSong(_ song: MerceSong) {
        guard let songURLString = song.url, let songURL = URL(string: songURLString) else {
            print("Invalid song url")
            return
        }
        self.audioAVPlayer = AVPlayer(url: songURL)
        self.audioAVPlayer?.play()
        self.currentSong = song
        self.isPlaying = true
    }
    
//    var currentTime: TimeInterval {
//        audioPlayer?.currentTime ?? 0.0
//    }

    
    func togglePlay() {
        if (isPlaying) {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        if let player = audioAVPlayer {
            withAnimation(.none) {
                player.play()
                isPlaying = true
            }
        }
    }
    
    func pause() {
        if let player = audioAVPlayer {
            withAnimation(.none) {
                player.pause()
                isPlaying = false
            }
        }
    }
}
