//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    
    var body: some View {
        OneSText(text: manager.bodyText, font: .body2, color: manager.textColor)
    }
}
