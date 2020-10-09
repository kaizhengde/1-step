//
//  OneSFillButton.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSFillButton: View {
    
    var text: String
    var textColor: Color
    var buttonColor: Color
    
    var width: CGFloat
    var height: CGFloat
    
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            OneSText(text: text, font: .custom(weight: Raleway.bold, size: 20), color: textColor)
            .frame(width: width*ScreenSize.width, height: height)
            .background(buttonColor)
            .cornerRadius(12)
            .animation(nil)
        }
        .oneSScaleStyle()
    }
}
