//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @StateObject private var popupManager = PopupManager.shared
    @StateObject private var floaterManager = FloaterManager.shared 
    let mountainColor: UserColor
    
    
    var body: some View {
        Text("Hi").onTapGesture {
            popupManager.showTextPopup(titleText: "Oh deer", titleImage: Emoji.deer, bodyText: "You should enter a goal.\n\nThis is what this app is all about.", backgroundColor: mountainColor.get())
            
            //floaterManager.showTextFloater(titleText: "Hurray 🎉", bodyText: "You have climed 3 mountains", backgroundColor: mountainColor.get())
        }
    }
}
