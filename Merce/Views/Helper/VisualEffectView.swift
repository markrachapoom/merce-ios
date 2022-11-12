//
//  VisualEffectView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    // MARK: - INIT
    
    var blurEffect: UIBlurEffect.Style
    
    // MARK: - MAKE AND UPDATE
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        let uiVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: blurEffect))
        return uiVisualEffectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = UIBlurEffect(style: blurEffect)
    }
}
