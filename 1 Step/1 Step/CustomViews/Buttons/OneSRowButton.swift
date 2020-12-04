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
    
    let title: String
    let textColor: Color
    let backgroundColor: Color
    
    let accessorySFSymbol: Image?
    let accessoryCustomSymbol: Image?
    let accessoryText: String?
    let accessoryColor: Color
    
    let action: () -> ()
    
    init(_ buttonArt: OneSRowButtonArt,
         title: String,
         textColor: Color                   = .grayToBackground,
         backgroundColor: Color             = .whiteToDarkGray,
         accessorySFSymbol: Image?          = nil,
         accessoryCustomSymbol: Image?      = nil,
         accessoryText: String? = nil,
         accessoryColor: Color              = .grayToBackground,
         action: @escaping () -> ()
    ) {
        self.buttonArt = buttonArt
        self.title = title
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
                OneSText(text: title, font: .body, color: textColor)
                    .padding(.vertical, buttonArt != .shortSmall ? Layout.firstLayerPadding : 0)
                Spacer()
                AccessoryView(sFSymbol: accessorySFSymbol, customSymbol: accessoryCustomSymbol, title: accessoryText, color: accessoryColor)
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .frame(maxWidth: buttonArt == .long ? .infinity : 280*Layout.multiplierWidth)
            .frame(minHeight: buttonArt == .shortSmall ? 56 : 72)
            .background(backgroundColor)
            .cornerRadius(10)
            .oneSShadow(opacity: 0.05, blur: 10)
            .oneSAnimation()
        }
        .oneSButtonScaleStyle()
        .oneSItemTransition()
    }
    
    
    private struct AccessoryView: View {
        
        let sFSymbol: Image?
        let customSymbol: Image?
        let title: String?
        let color: Color
        
        
        var body: some View {
            Group {
                if let image = sFSymbol {
                    image
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(color)
                    
                } else if let image = customSymbol {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .colorMultiply(color)
                    
                } else if let text = title {
                    OneSText(text: text, font: .custom(.extraBold, 17), color: color)
                }
            }
        }
    }
}
