//
//  OneSTextField.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI
import Combine

struct OneSTextField: View {
    
    @Binding var input: String
    
    var placeholder: String
    var textFont: OneSFont
    var textColor: Color
    var textLimit: Int
    
    var keyboard: UIKeyboardType = .default
    var lowercased: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .leading) {
                if input.isEmpty {
                    OneSText(text: placeholder, font: textFont, color: .lightNeutralToLightGray)
                }
                
                TextField("", text: lowercased ? Binding(get: { input }, set: { input = $0.lowercased() }) : $input, onCommit: {})
                .onReceive(Just(input)) { _ in limitText(textLimit) }
                .font(textFont.get())
                .foregroundColor(textColor)
                .accentColor(textColor)
                .multilineTextAlignment(.leading)
                .keyboardType(keyboard)
                .disableAutocorrection(true)
            }
            .frame(height: 40)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightNeutralToLightGray)
        }
        .frame(maxWidth: .infinity)
        .animation(nil)
    }
    
    
    func limitText(_ upper: Int) {
        if input.count > upper {
            input = String(input.prefix(upper))
        }
    }
}
