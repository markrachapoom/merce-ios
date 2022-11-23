//
//  EditProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/16.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let user: MerceUser
    @ObservedObject private var authVM: AuthenticationViewModel
    
    init(user: MerceUser, authVM: AuthenticationViewModel) {
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.user = user
        self.authVM = authVM
    }
    
    
    @State private var isPickingCoverImage: Bool = false
    @State private var isPickingProfileImage: Bool = false
    
    // Editing Properties
    @State private var editingCoverUIImage: UIImage? = nil
    @State private var editingProfileUIImage: UIImage? = nil
    @State private var editingName: String = ""
    @State private var editingUsername: String = ""
    @State private var editingBio: String = ""
    
    @State private var isSaving: Bool = false
    
    private let profileImageSize: CGFloat = 110
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Button(action: {
                            K.impactOccur()
                            self.isPickingCoverImage = true
                        }, label: {
                            // COVER IMAGE
                            VStack {
                                if let selectedCoverUIImage = editingCoverUIImage {
                                    Image(uiImage: selectedCoverUIImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    AsyncImage(url: URL(string: user.coverImageURL ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Rectangle()
                                            .foregroundColor(.secondaryBackgroundColor)
                                    }
                                }
                            }//: VSTACK
                            .frame(width: geo.frame(in: .global).width, height: K.coverImageHeight)
                            .clipped()
                        })//: BUTTON
                        
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                Button(action: {
                                    K.impactOccur()
                                    self.isPickingProfileImage = true
                                }, label: {
                                    VStack {
                                        
                                        if let selectedProfileUIImage = editingProfileUIImage {
                                            Image(uiImage: selectedProfileUIImage)
                                                .resizable()
                                                .scaledToFill()
                                        } else {
                                            AsyncImage(url: URL(string: user.profileImageURL ?? "")) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                Circle()
                                                    .foregroundColor(.secondaryBackgroundColor)
                                            }
                                            
                                        }
                                    }
                                    .frame(width: profileImageSize, height: profileImageSize)
                                    .clipShape(Circle())
                                })//: BUTTON
                                
                                Spacer()
                                
                            }//: HSTACK
                            
                            
                            EditRow(title: "Name", alignment: .center) {
                                TextField("Enter your name", text: $editingName)
                            }
                            
                            Divider()
                            
                            EditRow(title: "Username", alignment: .center) {
                                TextField("Enter your username", text: $editingUsername)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                            }
                            
                            Divider()
                            
                            EditRow(title: "Bio") {
                                VStack(alignment: .trailing, spacing: 2) {
                                    
                                    TextEditor(text: $editingBio)
                                        .foregroundColor(Color(.label))
                                        .font(.system(size: K.fontSize))
                                        .frame(height: 125)
                                    //                                    .background(Color.secondaryBackgroundColor)
                                        .scrollContentBackground(.hidden)
                                        .padding(0)
                                    
                                    Text("\(editingBio.count)/300")
                                        .font(.footnote)
                                        .foregroundColor(editingBio.count > 300 ? .red : Color(.secondaryLabel))
                                    
                                }//: VSTACK
                            }
                            
                            Divider()
                            
                        }//: VSTACK
                        .offset(y: -(profileImageSize/2))
                        .padding(.horizontal)
                    }//: VSTACK
                    .padding(.top, 50)
                }//: SCROLLVIEW
                
                // NAV BAR
                VStack {
                    ZStack {
                        HStack {
                            
                            Button(action: {
                                K.impactOccur()
                                dismiss()
                            }, label: {
                                Text("Cancel")
                            })//: BUTTON
                            
                            Spacer()
                            
                            
                            if (isSaving) {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Button(action: {
                                    K.impactOccur()
                                    
                                    self.isSaving = true
                                    
                                    var updateData: [AnyHashable:Any] = [:]
                                    
                                    if let selectedCoverUIImage = editingCoverUIImage {
                                        StorageManager.shared.uploadImage(uid: user.uid, path: .coverImage, imageData: selectedCoverUIImage.jpegData(compressionQuality: 0.3)) { result in
                                            switch result {
                                            case .success(let downloadURLString):
                                                authVM.saveEditProfileChange(
                                                    updateData: [
                                                        "coverImageURL" : downloadURLString
                                                    ]) { result in
                                                        switch result {
                                                        case .success(let message):
                                                            print(message)
                                                        case .failure(let merceError):
                                                            print(merceError.errorMessage)
                                                        }
                                                    }
                                            case .failure(let merceErr):
                                                print(merceErr.errorMessage)
                                            }
                                        }
                                    }
                                    
                                    if let selectedProfileUIImage = editingProfileUIImage {
                                        StorageManager.shared.uploadImage(uid: user.uid, path: .profileImage, imageData: selectedProfileUIImage.jpegData(compressionQuality: 0.3)) { result in
                                            switch result {
                                            case .success(let downloadURLString):
                                                authVM.saveEditProfileChange(
                                                    updateData: [
                                                        "profileImageURL" : downloadURLString
                                                    ]) { result in
                                                        switch result {
                                                        case .success(let message):
                                                            print(message)
                                                        case .failure(let merceError):
                                                            print(merceError.errorMessage)
                                                        }
                                                    }
                                            case .failure(let merceErr):
                                                print(merceErr.errorMessage)
                                            }
                                        }
                                    }
                                    
                                    print("update data ", updateData)
                                    
                                    updateData.updateValue(editingName, forKey: "givenName")
                                    updateData.updateValue(editingUsername, forKey: "username")
                                    updateData.updateValue(editingBio, forKey: "bio")
                                    
                                    authVM.saveEditProfileChange(updateData: updateData) { result in
                                        switch result {
                                            case .success(_):
                                                self.isSaving = false
                                                dismiss()
                                            case .failure(let merceError):
                                                print(merceError.errorMessage)
                                        }
                                    }
                                    
                                }, label: {
                                    Text("Save")
                                        .fontWeight(.semibold)
                                })//: BUTTON
                            }//: IS SAVING CONDITION
                            
                        }//: HSTACK
                        .foregroundColor(Color(.label))
                        
                        HStack {
                            Spacer()
                            Text("Edit profile")
                                .font(.navigationInlineTitle())
                            Spacer()
                        }//: HSTACK
                        
                    }//: ZSTACK
                    .frame(height: 24)
                    .padding(.top, K.topSafeArea)
                    .padding(.vertical, 13)
                    .padding(.horizontal)
                    .background(
                        VisualEffectView(blurEffect: .dark)
                            .overlay(
                                Color.black.opacity(0.65)
                            )//: OVERLAY
                    )//: BACKGROUND
                    
                    Spacer()
                }//: VSTACK
                .edgesIgnoringSafeArea(.top)
            }//: ZSTACK
            .fullScreenCover(isPresented: $isPickingCoverImage, content: {
                PHPickerView(imagesLimit: 1, selectedImage: $editingCoverUIImage)
                    .edgesIgnoringSafeArea(.all)
            })//: FULLSCREEN
            .fullScreenCover(isPresented: $isPickingProfileImage, content: {
                PHPickerView(imagesLimit: 1, selectedImage: $editingProfileUIImage)
                    .edgesIgnoringSafeArea(.all)
            })//: FULLSCREEN
        }//: GEOMETRYREADER
        .onAppear {
            self.editingName = user.givenName ?? ""
            self.editingUsername = user.username ?? ""
            self.editingBio = user.bio ?? ""
        }
    }
}

struct EditRow<Content: View>: View {
    
    var title: String
    var alignment: VerticalAlignment
    var content: Content
    
    init(title: String, alignment: VerticalAlignment = .top, @ViewBuilder content: () -> Content) {
        self.title = title
        self.alignment = alignment
        self.content = content()
    }
    
    var body: some View {
        HStack(alignment: alignment, spacing: 13) {
            HStack {
                Text(title)
                    .font(.system(size: K.fontSize, weight: .semibold))
                Spacer()
            }//: HSTACK
            .frame(width: 80)
            content
        }//: HSTACK
        .font(.system(size: K.fontSize))
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: MerceUser.sampleEntrepreneur, authVM: AuthenticationViewModel())
            .preferredColorScheme(.dark)
    }
}
