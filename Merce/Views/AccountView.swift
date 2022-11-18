//
//  AccountView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var authVM: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ProfileView(user: authVM.currentMerceUser ?? MerceUser(), isProfileOwner: true)
        }//: NAVIGATION VIEW
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AuthenticationViewModel())
    }
}
