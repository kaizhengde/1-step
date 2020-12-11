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
    
    init(text: String, font: OneSFont, color: Color, alignment: TextAlignment = .leading) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
    }
    
    
    var body: some View {
        Text(text)
            .font(font.font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .minimumScaleFactor(0.9)
    }
}



