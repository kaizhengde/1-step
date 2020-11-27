//
//  OneSMultilineText.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct OneSMultilineText: View {
    
    let text: String
    let bold: Bool
    let color: Color
    
    
    init(text: String, bold: Bool = false, color: Color = .grayToBackground) {
        self.text = text
        self.bold = bold
        self.color = color
    }
    
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom(bold ? Raleway.semiBold.weight : Raleway.regular.weight, size: 17))
                .foregroundColor(color)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)
            
            Spacer()
        }
    }
}

