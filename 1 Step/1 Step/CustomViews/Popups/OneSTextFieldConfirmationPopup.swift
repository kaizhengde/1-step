//
//  OneSTextFieldConfirmationPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

struct OneSTextFieldConfirmationPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    let titleText: String
    let bodyText: String
    let textColor: Color
    
    let confirmationText: String
    let placeholder: String
    let placeholderColor: Color
    let inputLimit: Int
    let keyboard: UIKeyboardType
    let lowercased: Bool
    
    @State private var input: String = ""
    
    
    init(titleText: String,
         bodyText: String,
         textColor: Color           = .backgroundToGray,
         confirmationText: String,
         placeholder: String,
         placeholderColor: Color,
         inputLimit: Int,
         keyboard: UIKeyboardType   = .default,
         lowercased: Bool           = false
    ) {
        self.titleText          = titleText
        self.bodyText           = bodyText
        self.textColor          = textColor
        
        self.confirmationText   = confirmationText
        self.placeholder        = placeholder
        self.placeholderColor   = placeholderColor
        self.inputLimit         = inputLimit
        self.keyboard           = keyboard
        self.lowercased         = lowercased
    }

    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    OneSSecondaryHeaderText(text: titleText, color: textColor)
                    Spacer()
                    if input == confirmationText {
                        OneSSmallBorderButton(symbol: SFSymbol.`continue`, color: textColor, withScale: false) { manager.confirmBtnDismiss(with: input) }
                    } else {
                        Color.clear.frame(width: 0, height: 38)
                    }
                }
                
                OneSMultilineText(text: bodyText, color: textColor)
                OneSTextField(input: $input, placeholder: placeholder, inputColor: textColor, placeholderColor: placeholderColor, inputLimit: inputLimit, keyboard: keyboard, lowercased: lowercased) {}
                
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 20)
    }
}

