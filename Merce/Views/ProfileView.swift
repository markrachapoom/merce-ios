//
//  ProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct ProfileView: View {
    
    let user: MerceUser
    let isProfileOwner: Bool
    
    init(user: MerceUser, isProfileOwner: Bool = false) {
        self.user = user
        self.isProfileOwner = isProfileOwner
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditingProfile: Bool = false
    
    @State private var minY: CGFloat = 0.0
    
    private let profileImageSize: CGFloat = 110
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.black
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        GeometryReader { coverImageGeo in
                            
                            // COVER IMAGE
                            AsyncImage(url: URL(string: user.coverImageURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Rectangle()
                                    .foregroundColor(.secondaryBackgroundColor)
                            }
                            .frame(width: coverImageGeo.size.width, height: minY < -K.coverImageHeight ? 0 : abs(coverImageGeo.size.height + minY))
                            .clipped()
                            .offset(y: -minY)
                            .onChange(of: coverImageGeo.frame(in: .global).minY, perform: { value in
                                self.minY = value
                            })
                        }
                        .frame(width: geo.frame(in: .global).width, height: K.coverImageHeight)
                        
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
                                
                                if (isProfileOwner) {
                                    Button(action: {
                                        K.impactOccur()
                                        self.isEditingProfile = true
                                    }, label: {
                                        Text("Edit Profile")
                                            .foregroundColor(Color(.label))
                                            .fontWeight(.semibold)
                                            .font(.system(size: K.fontSize - 1))
                                            .frame(height: 36)
                                            .padding(.horizontal, 13)
                                            .background(Color.secondaryBackgroundColor)
                                            .clipShape(Capsule())
                                    })//: EDIT PROFILE BUTTON
                                    .offset(y: 18 + 13)
                                }//: CONDITION
                                
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
                        
                        Spacer()

                    }
                }
            }//: ZSTACK
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isEditingProfile, content: {
                EditProfileView(user: user)
            })//: FULLSCREEN COVER
            .toolbar {
                
                if (!isProfileOwner) {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            K.impactOccur()
                            dismiss()
                        }, label: {
                            CircleIcon(iconName: "arrow.left")
                        })
                    }//: BACK BUTTON
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 4) {
                        
                        if (isProfileOwner) {
                            NavigationLink(destination: SettingsView()) {
                                CircleIcon(iconName: "gearshape")
                            }//: NAVIGATIONLINK
                            .simultaneousGesture(
                                TapGesture()
                                    .onEnded({ _ in
                                        K.impactOccur()
                                    })
                            )//: SIMULTANIOUS
                        }//: CONDITION
                        
                        Menu {
                            Button(action: {}, label: {
                                Label("Share Profile", systemImage: "square.and.arrow.up")
                            })
                        } label: {
                            CircleIcon(iconName: "ellipsis")
                        }//: ELLIPSIS MENU
                        .onTapGesture {
                            K.impactOccur()
                        }//: TAP GESTURE
                    }//: HSTACK
                }
            }
        }//: GEOMETRYREADER
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(user: MerceUser.sampleEntrepreneur)
                .preferredColorScheme(.dark)
        }
    }
}
