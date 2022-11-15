//
//  AuthenticationViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    @Published var currentUser: User? = nil
    
    func addStateDidChangeListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.currentUser = user
        }
    }
    
    
    
}
