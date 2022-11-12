//
//  MailView.swift
//  DiaryDingo
//
//  Created by Mark Rachapoom on 8/8/21.
//

import Foundation
import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    
    // MARK: - INIT
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    
    // MARK: - COORDINATOR
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        // INIT
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }
        
        
        // METHOD
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            
            self.result = .success(result)
        }
        
    }//: COORDINATOR CLASS
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }
    
    
    // MARK: - MAKE AND UPDATE
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(["diarydingo@gmail.com"])
        return viewController
    }
    
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
        // No update for MailView
    }
    
}
