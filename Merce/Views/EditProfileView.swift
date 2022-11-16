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
    
    init(user: MerceUser) {
        self.user = user
    }
    
    private let profileImageSize: CGFloat = 110
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // COVER IMAGE
                        AsyncImage(url: URL(string: user.coverImageURL ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .foregroundColor(.secondaryBackgroundColor)
                        }
                        .frame(width: geo.frame(in: .global).width, height: K.coverImageHeight)
                        .clipped()
                        
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                
                                AsyncImage(url: URL(string: user.profileImageURL ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundColor(.secondaryBackgroundColor)
                                }
                                .frame(width: profileImageSize, height: profileImageSize)
                                
                                Spacer()
                                
                            }//: HSTACK
                            
                            VStack(alignment: .leading) {
                                Text(user.name ?? "Unknown")
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
                                dismiss()
                            }, label: {
                                Text("Save")
                            })//: BUTTON
                            
                        }//: HSTACK
                        
                        HStack {
                            Spacer()
                            Text("Edit Profile")
                                .fontWeight(.semibold)
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
        }//: GEOMETRYREADER
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: MerceUser.sampleEntrepreneur)
    }
}
