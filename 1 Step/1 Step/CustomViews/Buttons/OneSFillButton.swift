//
//  OneSFillButton.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSFillButton: View {
    
    var text: String
    var textFont: OneSFont
    var textColor: Color
    var buttonColor: Color
    
    var width: CGFloat = .infinity
    var height: CGFloat
    
    var withScale: Bool = true
    
    let action: () -> ()
    
    
    var body: some View {
        Group {
            if withScale {
                ButtonContent(text: text, textFont: textFont, textColor: textColor, buttonColor: buttonColor, width: width, height: height, action: action)
                    .oneSButtonScaleStyle()
            } else {
                ButtonContent(text: text, textFont: textFont, textColor: textColor, buttonColor: buttonColor, width: width, height: height, action: action)
            }
        }
    }
    
    
    private struct ButtonContent: View {
        
        var text: String
        var textFont: OneSFont
        var textColor: Color
        var buttonColor: Color
        
        var width: CGFloat
        var height: CGFloat
        
        let action: () -> ()
        
        
        var body: some View {
            Button(action: action) {
                OneSText(text: text, font: textFont, color: textColor, alignment: .center)
                    .frame(minHeight: height)
                    .frame(maxWidth: width)
                    .background(buttonColor)
                    .cornerRadius(12)
            }
        }
    }
}
