//
//  SettingsView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
    @State private var isLogoutAlertShown: Bool = false
    
    var body: some View {
        ZStack {
            
            ScrollView(.vertical) {
                VStack {
                    
                    SettingsRowView(label: "Haptics", iconName: "hand.tap", trailingContent: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                    })
                    
                    SettingsRowView(label: "Story of Merce", iconName: "book.closed", trailingContent: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                    })
                    
                    Button(action: {
                        K.impactOccur()
                        isLogoutAlertShown = true
                    }, label: {
                        SettingsRowView(label: "Log Out", iconName: "rectangle.portrait.and.arrow.right", color: .red, trailingContent: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 14))
                                .rotationEffect(Angle(degrees: 90))
                                .foregroundColor(.red)
                        })
                    })//: BUTTON
                    
                }//: VSTACK
                .padding(.vertical, K.topSafeArea + 26)
            }//: SCROLLVIEW
            
            NavBarView(title: "Settings")
        }//: ZSTACK
        .navigationBarBackButtonHidden(true)
        .alert("Log Out?", isPresented: $isLogoutAlertShown) {
            Button("Logout", role: .destructive, action: {
//                authVM.signOut()
                withAnimation {
                    authVM.signOut()
                }
            })
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthenticationViewModel())
    }
}
