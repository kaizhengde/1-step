//
//  OneSText.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct OneSText: View {
    
    let text: String
    let font: OneSFont
    let color: Color
    let alignment: TextAlignment
    let minimumScale: CGFloat
    
    init(text: String, font: OneSFont, color: Color, alignment: TextAlignment = .leading, minimumScale: CGFloat = 1.0) {
        self.text           = text
        self.font           = font
        self.color          = color
        self.alignment      = alignment
        self.minimumScale   = minimumScale
    }
    
    
    var body: some View {
        Text(text)
            .font(font.font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .minimumScaleFactor(minimumScale)
            .lineLimit(3 + Int(Layout.onlyOniPhoneXType(1)))
    }
}



