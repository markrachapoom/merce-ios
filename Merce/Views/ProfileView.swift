//
//  ProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct ProfileView: View {
    
    let userData: MerceUser
    
    init(userData: MerceUser) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        self.userData = userData
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var minY: CGFloat = 0.0
    
    private let profileImageSize: CGFloat = 120
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.black
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
//                        if let uiImage = storiesVM.storyUIImage {
//                            Image(uiImage: uiImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geo.size.width, height: geo.size.height + (minY <= 0 ? 0 : minY) )
//                                .clipped()
//                                .offset(y: -minY / (minY <= 0 ? 1.75 : 1) )
//                                .opacity(minY < 0 ? opacity : 1)
//                                .animation(.none)
//                                .onChange(of: geo.frame(in: .global).minY, perform: { value in
//                                    self.minY = value
//                                })
//                                .background(Color.dingoBackground)
//                        } else {
//                            Rectangle()
//                                .foregroundColor(.dingoTertiary)
//                                .frame(width: geo.size.width,
//                                       height: geo.size.height + (minY <= 0 ? 0 : minY) )
//                                .offset(y: -minY / (minY <= 0 ? 3 : 1) )
//                                .opacity(minY < 0 ? opacity : 1)
//                                .animation(.none)
//                                .onChange(of: geo.frame(in: .global).minY, perform: { value in
//                                    self.minY = value
//                                })
//                        }//: CONDITION
                        
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
                        
                        VStack(alignment: .leading, spacing: 16) {
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        K.impactOccur()
                        dismiss()
                    }, label: {
                        
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black.opacity(0.5))
                            .overlay {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                    })
                }//: BACK BUTTON
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        
                        Button(action: {}, label: {
                            Label("Add to queue", systemImage: "text.append")
                        })
                        
                        Button(action: {}, label: {
                            Label("Add to Playlist", systemImage: "text.badge.plus")
                        })
                        
                    } label: {
                        
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black.opacity(0.5))
                            .overlay {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                        
                    }//: ELLIPSIS MENU
                    .onTapGesture {
                        K.impactOccur()
                    }//: TAP GESTURE
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
