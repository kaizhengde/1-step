//
//  OneSTextFieldConfirmationPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

struct OneSTextFieldConfirmationPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OneSMultilineText(text: manager.bodyText, color: manager.textColor)
            OneSTextField(input: $manager.confirmationInput, placeholder: manager.placeholder, inputColor: manager.textColor, placeholderColor: manager.placeholderColor, inputLimit: manager.inputLimit, keyboard: .default, lowercased: false) {}
        }
    }
}

