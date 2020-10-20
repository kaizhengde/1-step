//
//  OneSTextFieldPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct OneSTextFieldPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OneSText(text: manager.bodyText, font: .body2, color: .backgroundToGray)
            OneSTextField(input: $manager.input, placeholder: manager.placerholder, inputColor: .backgroundToGray, placerholderColor: .opacityBackgroundDarker, inputLimit: manager.inputLimit, keyboard: manager.keyboard, lowercased: manager.lowercased) { manager.textFieldDismiss() }
        }
    }
}
