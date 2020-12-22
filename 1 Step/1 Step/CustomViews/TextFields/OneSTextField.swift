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
    var inputColor: Color
    var placeholderColor: Color = .lightNeutralToLightGray
    
    var inputLimit: Int
    
    var keyboard: UIKeyboardType = .default
    var lowercased: Bool = false
    
    var firstResponder: Bool = false
    
    var action: () -> () = {}
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .leading) {
                if input.isEmpty {
                    OneSText(text: placeholder, font: .header2, color: placeholderColor)
                }
                
                TextField("", text: lowercased ? Binding(get: { input }, set: { input = $0.lowercased() }) : $input, onCommit: { action() })
                .onChange(of: input) { _ in limitInput() }
                .font(OneSFont.header2.font)
                .foregroundColor(inputColor)
                .accentColor(inputColor)
                .multilineTextAlignment(.leading)
                .keyboardType(keyboard)
                .disableAutocorrection(true)
                .introspectTextField { textField in
                    if firstResponder {
                        textField.becomeFirstResponder()
                    }
                }
            }
            .frame(height: 40)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightNeutralToLightGray)
        }
        .frame(maxWidth: .infinity)
        .animation(nil)
    }
    
    
    func limitInput() {
        if input.count > inputLimit {
            input = String(input.prefix(inputLimit))
        }
    }
}

