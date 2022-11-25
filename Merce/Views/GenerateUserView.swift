//
//  GenerateUserView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/25.
//

import SwiftUI
import FirebaseFirestore

struct GenerateUserView: View {
    
    @State var uid: String = ""
    @State var profileImageURL: String = ""
    @State var coverImageURL: String = ""
    @State var name: String = ""
    @State var username: String = ""
    @State var bio: String = ""
    
    func click() {
        
        let db = Firestore.firestore()
        
        var updateData: [AnyHashable:Any] = [:]
        updateData.updateValue(profileImageURL, forKey: "profileImageURL")
        updateData.updateValue(coverImageURL, forKey: "coverImageURL")
        updateData.updateValue(name, forKey: "givenName")
        updateData.updateValue(username, forKey: "username")
        
        // Keywords For Loopup
        let keywordsForLookup: [String] = [
            username.generateStringSequence(),
            name.generateStringSequence(),
            name.generateWordsSplitBySpace()
        ].flatMap{$0}.compactMap{$0}
        updateData.updateValue(keywordsForLookup, forKey: "keywordsForLookup")
        updateData.updateValue(bio, forKey: "bio")
        updateData.updateValue("user", forKey: "type")
        
        let currentUserRef = db.collection("users").document(uid)
        
        currentUserRef.updateData(updateData) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Successfully added \(name)")
            }
        }
        
    }

    
    var body: some View {
        VStack {
            
            TextField("uid", text: $uid)
            TextField("profile image", text: $profileImageURL)
            TextField("cover", text: $coverImageURL)
            TextField("name", text: $name)
            TextField("username", text: $username)
            
            TextField("bio", text: $bio)
            
            Button(action: {
                click()
            }, label: {
                Text("Save")
                    .foregroundColor(.blue)
            })
        }
    }
}

struct GenerateUserView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateUserView()
    }
}
