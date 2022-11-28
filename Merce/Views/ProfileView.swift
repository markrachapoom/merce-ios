//
//  ProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
    let user: MerceUser
    let isBackButtonHidden: Bool
    
    init(user: MerceUser, isBackButtonHidden: Bool = false) {
        self.user = user
        self.isBackButtonHidden = isBackButtonHidden
    }
    
    var isProfileOwner: Bool {
        return authVM.currentMerceUser?.username == user.username
    }
    
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var isEditingProfile: Bool = false
    
    @State private var minY: CGFloat = 0.0
    
    private let profileImageSize: CGFloat = 110
    
    @State private var isFollowed: Bool = false
    
    func showActivitySheet() {
        guard let sharingUsername = user.username else { return }
        guard let urlShare = URL(string: "https://merce.app/\(sharingUsername)") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
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
                            .frame(width: coverImageGeo.size.width, height: minY < -(geo.frame(in: .global).width / 2) ? 0 : abs(coverImageGeo.size.height + minY))
                            .clipped()
                            .offset(y: -minY)
                            .onChange(of: coverImageGeo.frame(in: .global).minY, perform: { value in
                                self.minY = value
                            })
                        }
                        .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).width / 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                
                                AsyncImage(url: URL(string: user.profileImageURL ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundColor(.secondaryBackgroundColor)
                                }//: ASYNCIMAGE
                                .frame(width: profileImageSize, height: profileImageSize)
                                
                                Spacer()
                                
                            }//: HSTACK
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    
                                    Text(user.givenName ?? "Unknown")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    if (user.isVerified ?? false) {
                                        Image(systemName: "checkmark.seal.fill")
                                            .font(.system(size: K.fontSize - 2))
                                            .foregroundColor(.white)
                                    }
                                    
                                }//: HSTACK
                                Text("@\(user.username ?? "unknown")")
                                    .font(.system(size: K.fontSize))
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            
                            if let bio = user.bio, !bio.isEmpty {
                                Text(bio)
                                    .font(.system(size: K.fontSize))
                            }
                            
                            HStack {
                                
                                if (!isProfileOwner) {
                                    Button(action: {
                                        withAnimation(.none) {
                                            self.isFollowed.toggle()
                                        }
                                    }, label: {
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundColor(isFollowed ? Color(.separator) : .clear)
                                            .background(isFollowed ? .clear : .white)
                                            .overlay {
                                                Text(isFollowed ? "Followed" : "Follow")
                                                    .foregroundColor(isFollowed ? .white : .black)
                                            }
                                            .cornerRadius(100)
                                    })
                                    
                                    Button(action: {
                                    }, label: {
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundColor(Color(.separator))
                                            .background(.clear)
                                            .overlay {
                                                Text("Message")
                                            }//: OVERLAY
                                            .cornerRadius(100)
                                    })//: BUTTON
                                    
                                }//: IS-PROFILE-OWNER
                                
                                if (isProfileOwner) {
                                    Button(action: {
                                        self.isEditingProfile = true
                                    }, label: {
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundColor(Color(.separator))
                                            .background(.clear)
//                                            .foregroundColor(Color.secondaryBackgroundColor)
                                            .overlay {
                                                Text("Edit Profile")
                                                    .foregroundColor(Color(.label))
                                            }
                                            .cornerRadius(100)
                                    })//: EDIT BUTTON
                                    
                                    NavigationLink(destination: SavedView()) {
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundColor(Color(.separator))
                                            .background(.clear)
//                                            .foregroundColor(Color.secondaryBackgroundColor)
                                            .overlay {
                                                Text("Saved")
                                                    .foregroundColor(Color(.label))
                                            }
                                            .cornerRadius(100)
                                    }//: NAVIGATIONLINK
                                }//: ISPROFILEOWNER
                            }//: HSTACK
                            .font(.system(size: K.fontSize))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                            .frame(height: 36)
                            
                        }//: VSTACK
                        .offset(y: -(profileImageSize/2))
                        .padding(.horizontal)
                        
                        Spacer()

                    }//: VSTACK
                }//: SCROLLVIEW
            }//: ZSTACK
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isEditingProfile, content: {
                EditProfileView(user: user, authVM: authVM)
            })//: FULLSCREEN COVER
            .toolbar {
                
                if (!isBackButtonHidden) {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            CircleIcon(iconName: "arrow.left")
                        })
                    }//: BACK BUTTON
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 4) {
                        
                        if (!isProfileOwner) {
                            Menu {
                                Button(action: {
                                    showActivitySheet()
                                }, label: {
                                    Label("Share Profile", systemImage: "square.and.arrow.up")
                                })
                            } label: {
                                CircleIcon(iconName: "ellipsis")
                            }//: ELLIPSIS MENU
                        }
                        
                        if (isProfileOwner) {
                            Button(action: {
                                guard let sharingUsername = user.username else { return }
                                guard let urlShare = URL(string: "https://merce.app/\(sharingUsername)") else { return }
                                let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                            }, label: {
                                CircleIcon(iconName: "square.and.arrow.up")
                            })
                            
                            NavigationLink(destination: SettingsView()) {
                                CircleIcon(iconName: "gearshape")
                            }//: NAVIGATIONLINK
                        }
                        
                    }//: HSTACK
                }//: TABBARITEM
            }//: TOOLBAR
        }//: GEOMETRYREADER
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(user: MerceUser.sampleEntrepreneur)
                .environmentObject(AuthenticationViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
