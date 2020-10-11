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
    var inputColor: Color
    var placerholderColor: Color = .lightNeutralToLightGray
    
    var inputLimit: Int
    
    var keyboard: UIKeyboardType = .default
    var lowercased: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .leading) {
                if input.isEmpty {
                    OneSText(text: placeholder, font: .header2, color: placerholderColor)
                }
                
                TextField("", text: lowercased ? Binding(get: { input }, set: { input = $0.lowercased() }) : $input, onCommit: {})
                .onReceive(Just(input)) { _ in limitInput(inputLimit) }
                .font(OneSFont.header2.get())
                .foregroundColor(inputColor)
                .accentColor(inputColor)
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
    
    
    func limitInput(_ upper: Int) {
        if input.count > upper {
            input = String(input.prefix(upper))
        }
    }
}

