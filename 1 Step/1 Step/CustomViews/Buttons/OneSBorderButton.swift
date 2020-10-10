//
//  OneSBorderButton.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct OneSBorderButton: View {
    
    let text: String
    let color: Color
    let action: () -> ()
    
    
    var body: some View {
        Button(action: { action() }) {
            OneSText(text: text, font: .custom(weight: Raleway.bold, size: 19), color: color)
                .frame(width: 145 * Layout.multiplierWidth, height: 55)
                .contentShape(Rectangle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color.opacity(0.5), lineWidth: 1)
                )
        }
        .oneSScaleStyle()
    }
}
