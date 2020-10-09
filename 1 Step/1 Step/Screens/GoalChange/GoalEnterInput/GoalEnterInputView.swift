//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @StateObject private var popupManager = PopupManager.shared
    
    
    var body: some View {
        Button(action: {
            print("Hi")
            popupManager.showTextPopup(popupText: "It's working!!")
        }) {
            Text("Hi")
        }
    }
}
