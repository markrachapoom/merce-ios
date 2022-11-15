//
//  AuthenticationView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Image("man-with-headphone-black")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.frame(in: .global).width)
                    .clipped()
                
                VStack(spacing: 0) {
                    LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                    VStack {
                        HStack {
                            Spacer()
                        }
                    }
                    .frame(height: geo.frame(in: .global).height / 4)
                    .background(.black)
                }
                
                VStack {
                    
                    Spacer()
                    
                    VStack(spacing: 26) {
                        
                        Image("merce-icon-white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                        
                        VStack(spacing: 8) {
                            Text("Welcome to Merce")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("🎙 Where content meets music")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color(.secondaryLabel))
                                .multilineTextAlignment(.center)
                        }//: VSTACK
                        
                        VStack(spacing: 13) {
                            Button(action: {
                                withAnimation {
                                    K.impactOccur()
                                    authVM.continueWithGoogle()
                                }
                            }, label: {
                                HStack {
                                    
                                    Image("google-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 21)
                                    
                                    Spacer()
                                    
                                    Text("Continue with Google")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Spacer()
                                }//: HSTACK
                                .frame(height: 56)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                        .foregroundColor(Color(.separator))
                                )
                                .padding(.horizontal, 26)
                            })
                            
                            HStack {
                                
                                Image(systemName: "applelogo")
                                    .font(.system(size: 21))
                                
                                Spacer()
                                Text("Continue with Apple")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Spacer()
                            }//: HSTACK
                            .frame(height: 56)
                            .padding(.horizontal)
                            .background(
                                Capsule()
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundColor(Color(.separator))
                            )
                            .padding(.horizontal, 26)
                        }//: HSTACK
                        
                    }//: VSTACK
                    
//                    Spacer()
                    
                }//: VSTACK
                .padding(.bottom, K.bottomSafeArea + 40)
                
            }//: ZSTACK
            .edgesIgnoringSafeArea(.all)
        }//: GEO
        .preferredColorScheme(.dark)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .preferredColorScheme(.dark)
            .environmentObject(AuthenticationViewModel())
    }
}
