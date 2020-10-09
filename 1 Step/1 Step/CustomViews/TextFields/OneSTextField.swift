//
//  OneSTextField.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextField: View {
    
    @Binding var input: String
    
    var placeholder: String
    var textFont: OneSFont
    var textColor: Color
    
    var keyboard: UIKeyboardType = .default
    var lowercased: Bool = false
    
    var width: CGFloat
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .leading) {
                if input.isEmpty {
                    OneSText(text: placeholder, font: textFont, color: .lightNeutralToLightGray)
                }
                
                TextField("", text: lowercased ? Binding(get: { self.input }, set: { self.input = $0.lowercased() }) : $input, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .font(textFont.get())
                .foregroundColor(textColor)
                .accentColor(textColor)
                .multilineTextAlignment(.leading)
                .keyboardType(keyboard)
            }
            .frame(height: 40)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightNeutralToLightGray)
        }
        .frame(width: width*ScreenSize.width)
    }
}
