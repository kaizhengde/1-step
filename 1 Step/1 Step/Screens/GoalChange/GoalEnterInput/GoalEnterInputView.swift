//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @StateObject private var popupManager = PopupManager.shared
    let mountainColor: UserColor
    
    
    var body: some View {
        Button(action: {
            print("Hi")
            popupManager.showTextPopup(titleText: "Oh deer!", bodyText: "You have a too high number.\n\nNotice: The limit are 2000 Steps.", backgroundColor: mountainColor.get())
        }) {
            Text("Hi")
        }
    }
}
