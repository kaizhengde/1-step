//
//  OneSFootnoteButton.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI

struct OneSFootnoteButton: View {
    
    let text: String
    let color: Color
    let action: () -> ()
    
    
    var body: some View {
        Button(action: { action() }) {
            OneSText(text: text, font: .custom(.semiBold, 13), color: color)
                .contentShape(Rectangle())
        }
        .oneSButtonScaleStyle()
    }
}
