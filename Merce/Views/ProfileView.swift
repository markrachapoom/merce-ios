//
//  ProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct ProfileView: View {
    
    let userData: MerceUser
    let isProfileOwner: Bool
    
    init(userData: MerceUser, isProfileOwner: Bool = false) {
        self.userData = userData
        self.isProfileOwner = isProfileOwner
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var minY: CGFloat = 0.0
    
    private let profileImageSize: CGFloat = 110
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.black
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        GeometryReader { coverImageGeo in
                            AsyncImage(url: URL(string: userData.coverImageURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Rectangle()
                                    .foregroundColor(.secondaryBackgroundColor)
                            }
                            .frame(width: coverImageGeo.size.width, height: minY < -200 ? 0 : abs(coverImageGeo.size.height + minY))
                            .clipped()
                            .offset(y: -minY)
                            .onChange(of: coverImageGeo.frame(in: .global).minY, perform: { value in
                                self.minY = value
                            })
                        }
                        .frame(width: geo.frame(in: .global).width, height: 200)
                        
                        VStack(alignment: .leading, spacing: 11) {
                            HStack {
                                
                                AsyncImage(url: URL(string: userData.profileImageURL ?? "")) { image in
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
                                    }, label: {
                                        Text("Edit Profile")
                                            .foregroundColor(Color(.label))
                                            .fontWeight(.medium)
                                            .font(.system(size: K.fontSize))
                                            .frame(height: 36)
                                            .padding(.horizontal, 13)
                                            .background(Color.secondaryBackgroundColor)
                                            .clipShape(Capsule())
                                            .offset(y: 18 + 13)
                                    })//: EDIT PROFILE BUTTON
                                }
                                
                            }//: HSTACK
                            
                            VStack(alignment: .leading) {
                                Text(userData.name ?? "Unknown")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("@\(userData.username ?? "unknown")")
                                    .font(.system(size: K.fontSize))
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            
                            Text(userData.bio ?? "")
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
            ProfileView(userData: MerceUser.sampleEntrepreneur)
                .preferredColorScheme(.dark)
        }
    }
}
