//
//  SavedView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/17.
//

import SwiftUI

struct SavedView: View {
    var body: some View {
        ZStack {
            NavBarView(title: "Saved")
        }//: ZSTACK
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
