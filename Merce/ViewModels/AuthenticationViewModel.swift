//
//  AuthenticationViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import Foundation
import Firebase
//import FirebaseFirestore
import FirebaseFirestoreSwift
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    
    enum SignInState {
        case signedIn
        case signedOut
        case unknown
    }
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User? = nil
    @Published var currentMerceUser: MerceUser? = nil
    @Published var state: SignInState = .unknown
    
    let db = Firestore.firestore()
    
    func addStateDidChangeListener() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            Auth.auth().addStateDidChangeListener { auth, user in
                if (user != nil) {
                    self.currentUser = user
                    self.fetchCurrentUser(uid: user?.uid)
                    self.state = .signedIn
                } else {
                    self.state = .signedOut
                }
            }
        }
    }
    
    func fetchCurrentUser(uid: String?) -> Void {
        
        guard let uid = uid else { return }
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let fetchedUser: MerceUser? = try? document.data(as: MerceUser.self)
                
                guard let fetchedUser = fetchedUser else { return }
                
                self.currentMerceUser = fetchedUser
                
            } else {
//                self.state = .signedOut
                print("Current user does not exist")
            }
        }
    }
    
    
    func fetchUser(uid: String?, completion: @escaping(Result<MerceUser, MerceError>) -> Void) -> Void {
        guard let uid = uid else { return }
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                
                let fetchedUser: MerceUser? = try? document.data(as: MerceUser.self)
                
                guard let fetchedUser = fetchedUser else {
                    completion(.failure(.noUserFound))
                    return
                }
                
                completion(.success(fetchedUser))
                
            } else {
                print("Current user does not exist")
                completion(.failure(.noUserFound))
            }
        }
        
    }
    
    
}

extension AuthenticationViewModel {
    func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        
        // Guard Error
        guard error == nil else { return }
        guard let user = user else { return }
        
//        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        guard let idToken = user.authentication.idToken else { return }
        let accessToken = user.authentication.accessToken
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
            guard error == nil else { return }
            if let result = result {
                print("Result: \(result.user.uid)")
                self.createMerceUser(from: result.user)
                self.state = .signedIn
            }
        }
    }
    
    
    func continueWithGoogle() -> Void {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
    }
    
}


// LOG OUT
extension AuthenticationViewModel {
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.currentMerceUser = nil
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}



// Firebase Firestore/Storage
extension AuthenticationViewModel {
    
    func createMerceUser(from user: User) -> Void {
        
        let currentUserRef = db.collection("users").document(user.uid)
        
        currentUserRef.getDocument { (document, error) in
            if let document = document {
                if (document.exists) {
                    // User exist
                } else {
                    
                    let newUser: [String : Any] = [
                        "type": "user",
                        "uid": user.uid,
                        "coverImageURL": NSNull(),
                        "profileImageURL": user.photoURL?.absoluteString ?? NSNull(),
                        "givenName": user.displayName ?? NSNull(),
                        "isVerified" : false,
                        "username": UUID().uuidString,
                        "bio": NSNull(),
                        "email": user.email ?? NSNull(),
                        "followingCount": 0,
                        "followersCount": 0,
                        "joinedDate": Date(),
                        "keywordsForLookup": []
                    ]
                    
                    // Add a new document in users collection
                    self.db.collection("users").document(user.uid).setData(newUser){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }//: CONDITION
            }//: UNWRAP
        }//: GETDOC
        
        self.fetchCurrentUser(uid: user.uid)
    }
    
    
    func saveEditProfileChange(updateData: [AnyHashable: Any]?, completion: @escaping(Result<String, MerceError>) -> Void) -> Void {
        
        guard let currentUser = currentUser else {
            print("No current user while saving changes")
            completion(.failure(.noCurrentUser))
            return
        }
        
        guard let updateData = updateData else {
            print("Update data is nil")
            return
        }
        
        guard !updateData.isEmpty else {
            print("Update data is empty")
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.uid)
        
        currentUserRef.updateData(updateData) { err in
            if let err = err {
                completion(.failure(.failedToUpdateCurrentUserData))
                print("Error updating document: \(err)")
            } else {
                self.fetchCurrentUser(uid: currentUser.uid)
                completion(.success("Current user successfully updated"))
            }
        }
    }
    
}
