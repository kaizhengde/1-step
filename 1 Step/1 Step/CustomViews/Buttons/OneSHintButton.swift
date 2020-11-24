//
//  OneSArrowButton.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct OneSHintButton: View {
    
    let text: String
    let color: Color
    let action: () -> ()
    
    
    var body: some View {
        Button(action: { action() }) {
            HStack {
                OneSText(text: text, font: .body, color: color)
                SFSymbol.`continue`
                    .font(OneSFont.custom(.semiBold, 15).font)
                Spacer()
            }
            .frame(width: 200, height: 30)
            .foregroundColor(color)
            .contentShape(Rectangle())
        }
        .oneSButtonScaleStyle()
    }
}
