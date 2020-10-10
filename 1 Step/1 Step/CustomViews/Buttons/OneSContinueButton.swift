//
//  OneSContinueButton.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSContinueButton: View {
    
    let color: Color
    var withScale: Bool = true
    let action: () -> ()
    
    
    var body: some View {
        Group {
            if withScale {
                ButtonContent(color: color, action: action)
                    .oneSButtonScaleStyle()
            } else {
                ButtonContent(color: color, action: action)
            }
        }
    }
    
    
    private struct ButtonContent: View {
        
        let color: Color
        let action: () -> ()
        
        
        var body: some View {
            Button(action: { action() }) {
                SFSymbol.arrow
                    .font(OneSFont.custom(weight: Raleway.bold, size: 19).get())
                    .frame(width: 68 * Layout.multiplierWidth, height: 38)
                    .foregroundColor(color)
                    .contentShape(Rectangle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color.opacity(0.5), lineWidth: 1)
                    )
            }
        }
    }
}
