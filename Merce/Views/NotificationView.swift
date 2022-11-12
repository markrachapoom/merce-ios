//
//  NotificationView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/13.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ZStack {
            NavBarView(title: "Notifications", withBackButton: false)
        }//: ZSTACK
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
