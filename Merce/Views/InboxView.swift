//
//  InboxView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        ZStack {
            NavBarView(title: "Inbox")
        }//: ZSTACK
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
