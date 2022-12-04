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
    
    @Published var currentAverageColor: Color?
    
    @Published var isPlaying: Bool = false
    
//    @Published var currentTime: TimeInterval = .zero
    
    init() {
        // Set AvAudio or fetch latest song to play when the app launched
        setInitialSong()
    }
    
    func playSong(_ song: MerceSong) {
//        guard let songURLString = song.url, let songURL = URL(string: songURLString) else {
//            print("Invalid song url")
//            return
//        }
//        self.audioAVPlayer = AVPlayer(url: songURL)
        
        let path = Bundle.main.path(forResource: "song-\(song.id)", ofType: "mp3") ?? ""
        self.audioAVPlayer = AVPlayer(url: URL(filePath: path))
        self.audioAVPlayer?.play()
        self.currentSong = song
        self.isPlaying = true
    }
    
    func setInitialSong() {
        let path = Bundle.main.path(forResource: "song-3", ofType: "mp3") ?? ""
        self.audioAVPlayer = AVPlayer(url: URL(filePath: path))
        self.currentSong = MerceSong.sampleSongs[2]
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

extension PlayerViewModel {
    func resetState() {
        self.audioAVPlayer = nil
        self.currentSong = nil
        self.isPlaying = false
    }
}
