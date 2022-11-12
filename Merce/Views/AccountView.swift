//
//  AccountView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/12.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            ProfileView(userData: MerceUser.markrachapoom, withBackButton: false)
        }//: NAVIGATION VIEW
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
