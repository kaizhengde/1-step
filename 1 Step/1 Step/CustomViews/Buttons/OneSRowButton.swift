//
//  OneSLongButton.swift
//  1 Step
//
//  Created by Kai Zheng on 20.11.20.
//

import SwiftUI

enum OneSRowButtonArt {
    
    case long, shortBig, shortSmall
}


struct OneSRowButton: View {
    
    let buttonArt: OneSRowButtonArt
    
    let text: String
    let textColor: Color
    let backgroundColor: Color
    
    let accessorySFSymbol: Image?
    let accessoryCustomSymbol: Image?
    let accessoryText: String?
    let accessoryColor: Color
    
    let action: () -> ()
    
    init(_ buttonArt: OneSRowButtonArt,
         text: String,
         textColor: Color               = .grayToBackground,
         backgroundColor: Color         = .whiteToDarkGray,
         accessorySFSymbol: Image?      = nil,
         accessoryCustomSymbol: Image?  = nil,
         accessoryText: String?         = nil,
         accessoryColor: Color          = .grayToBackground,
         action: @escaping () -> ()
    ) {
        self.buttonArt = buttonArt
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.accessorySFSymbol = accessorySFSymbol
        self.accessoryCustomSymbol = accessoryCustomSymbol
        self.accessoryText = accessoryText
        self.accessoryColor = accessoryColor
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            HStack {
                OneSText(text: text, font: .body, color: textColor)
                Spacer()
                AccessoryView(sFSymbol: accessorySFSymbol, customSymbol: accessoryCustomSymbol, text: accessoryText, color: accessoryColor)
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .frame(maxWidth: buttonArt == .long ? .infinity : 280*Layout.multiplierWidth)
            .frame(height: buttonArt == .shortSmall ? 54 : 70)
            .background(backgroundColor)
            .cornerRadius(10)
            .oneSShadow(opacity: 0.1, y: 2, blur: 10)
            .oneSAnimation()
        }
        .oneSButtonScaleStyle()
    }
    
    
    private struct AccessoryView: View {
        
        let sFSymbol: Image?
        let customSymbol: Image?
        let text: String?
        let color: Color
        
        
        var body: some View {
            Group {
                if let image = sFSymbol {
                    image
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(color)
                    
                } else if let image = customSymbol {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .colorMultiply(color)
                    
                } else if let text = text {
                    OneSText(text: text, font: .custom(weight: Raleway.bold, size: 17), color: color)
                }
            }
        }
    }
}
