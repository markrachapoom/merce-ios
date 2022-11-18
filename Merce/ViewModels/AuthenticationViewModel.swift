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
                    self.state = .signedIn
                } else {
                    self.state = .signedOut
                }
            }
        }
    }
    
    func fetchCurrentUser(uid: String) -> Void {
        
        let docRef = db.collection("users").document(uid)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let data = document.data()
                
//                var fetchedUser: MerceUser = MerceUser(
//                    type: data["type"],
//                    uid: data["uid"],
//                    givenName: data["givenName"]
//                )

            } else {
                print("Current user does not exist")
            }
        }
    }
    
    
}

extension AuthenticationViewModel {
    func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        
        // GUard Error
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


extension AuthenticationViewModel {
    
    func createMerceUser(from user: User) -> Void {
        
        let docRef = db.collection("users").document(user.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document {
                if (document.exists) {
                } else {
                    // Add a new document in collection "cities"
                    self.db.collection("users").document(user.uid).setData([
                        "uid": user.uid,
                        "email": user.email ?? "",
                        "displayName": user.displayName ?? "",
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    } catch (let error) {
                        
                    }
                }//: CONDITION
            }//: UNWRAP
        }//: GETDOC
        
        
        self.fetchCurrentUser(uid: user.uid)
    }
}


// LOG OUT
extension AuthenticationViewModel {
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
