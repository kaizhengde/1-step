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
    
    init(text: String, bold: Bool = false) {
        self.text = text
        self.bold = bold
    }
    
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom(bold ? Raleway.semiBold.weight : Raleway.regular.weight, size: 17))
                .foregroundColor(.grayToBackground)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)
            
            Spacer()
        }
    }
}

