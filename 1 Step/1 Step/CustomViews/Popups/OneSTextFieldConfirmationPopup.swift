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
            OneSText(text: manager.bodyText, font: .body2, color: .backgroundToGray)
            OneSTextField(input: $manager.confirmationInput, placeholder: manager.placerholder, inputColor: .backgroundToGray, placerholderColor: .opacityBackgroundDarker, inputLimit: manager.inputLimit, keyboard: .default, lowercased: false) {}
        }
    }
}

