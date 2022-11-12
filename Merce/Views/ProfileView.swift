//
//  ProfileView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/11.
//

import SwiftUI

struct ProfileView: View {
    
    let userData: MerceUser
    let withBackButton: Bool
    
    init(userData: MerceUser, withBackButton: Bool = true) {
        self.userData = userData
        self.withBackButton = withBackButton
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
                
                if (withBackButton) {
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
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        
                        Button(action: {}, label: {
                            Label("Share Profile", systemImage: "square.and.arrow.up")
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
