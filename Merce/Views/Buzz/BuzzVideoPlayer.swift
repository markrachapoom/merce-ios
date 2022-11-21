//
//  BuzzVideoPlayer.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/21.
//

import Foundation
import SwiftUI
import AVKit

struct BuzzVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        
        controller.videoGravity = .resizeAspectFill
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
