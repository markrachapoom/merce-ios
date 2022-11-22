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
        self.user = user
        self.authVM = authVM
    }
    
    @State private var selectedCoverUIImage: UIImage? = nil
    @State private var selectedProfileUIImage: UIImage? = nil
    
    @State private var isPickingCoverImage: Bool = false
    @State private var isPickingProfileImage: Bool = false
    
    private let profileImageSize: CGFloat = 110
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Button(action: {
                            self.isPickingCoverImage = true
                        }, label: {
                            // COVER IMAGE
                            VStack {
                                if let selectedCoverUIImage = selectedCoverUIImage {
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
                            }
                            .frame(width: geo.frame(in: .global).width, height: K.coverImageHeight)
                            .clipped()
                        })
                        
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                Button(action: {
                                    self.isPickingProfileImage = true
                                }, label: {
                                    VStack {
                                        if let selectedProfileUIImage = selectedProfileUIImage {
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
                            
                            VStack(alignment: .leading) {
                                Text(user.givenName ?? "Unknown")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("@\(user.username ?? "unknown")")
                                    .font(.system(size: K.fontSize))
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            
                            Text(user.bio ?? "")
                                .font(.system(size: K.fontSize))
                            
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
                            
                            Button(action: {
                                K.impactOccur()
                                
                                var updateData: [AnyHashable:Any] = [:]
                                
                                if let selectedCoverUIImage = selectedCoverUIImage {
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
                                
                                if let selectedProfileUIImage = selectedProfileUIImage {
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
                                
                                authVM.saveEditProfileChange(updateData: updateData) { result in
                                    
                                }
                                
                            }, label: {
                                Text("Save")
                            })//: BUTTON
                            
                        }//: HSTACK
                        
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
                PHPickerView(imagesLimit: 1, selectedImage: $selectedCoverUIImage)
                    .edgesIgnoringSafeArea(.all)
            })//: FULLSCREEN
            .fullScreenCover(isPresented: $isPickingProfileImage, content: {
                PHPickerView(imagesLimit: 1, selectedImage: $selectedProfileUIImage)
                    .edgesIgnoringSafeArea(.all)
            })//: FULLSCREEN
        }//: GEOMETRYREADER
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: MerceUser.sampleEntrepreneur, authVM: AuthenticationViewModel())
    }
}
