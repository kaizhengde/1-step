//
//  OneSTextFieldPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct OneSTextFieldPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    let titleText: String
    let bodyText: String
    let textColor: Color
    
    let initialInput: String
    let placeholder: String
    let placeholderColor: Color
    let inputLimit: Int
    let keyboard: UIKeyboardType
    let lowercased: Bool
    let firstResponder: Bool
    
    @State private var input: String = ""
    
    
    init(titleText: String,
         bodyText: String,
         textColor: Color           = .backgroundToGray,
         initialInput: String,
         placeholder: String,
         placeholderColor: Color,
         inputLimit: Int,
         keyboard: UIKeyboardType   = .default,
         lowercased: Bool           = false,
         firstResponder: Bool       = false
    ) {
        self.titleText          = titleText
        self.bodyText           = bodyText
        self.textColor          = textColor
        
        self.initialInput       = initialInput
        self.placeholder        = placeholder
        self.placeholderColor   = placeholderColor
        self.inputLimit         = inputLimit
        self.keyboard           = keyboard
        self.lowercased         = lowercased
        self.firstResponder     = firstResponder
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    OneSSecondaryHeaderText(text: titleText, color: textColor)
                    Spacer()
                    OneSSmallBorderButton(symbol: SFSymbol.`continue`, color: textColor, withScale: false) { manager.confirmBtnDismiss(with: input) }
                }
                
                OneSMultilineText(text: bodyText, color: textColor)
                OneSTextField(input: $input, placeholder: placeholder, inputColor: textColor, placeholderColor: placeholderColor, inputLimit: inputLimit, keyboard: keyboard, lowercased: lowercased, firstResponder: firstResponder) { manager.confirmBtnDismiss(with: input) }
                
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 20)
        .onAppear { input = initialInput }
    }
}
