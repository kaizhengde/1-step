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
                OneSTextView(text: text, font: .custom(weight: Raleway.bold, size: 19), color: color)
                    .frame(width: 145 * ScreenSize.multiplierWidth, height: 40)
            }
            .contentShape(Rectangle())
        }
        .oneSScaleStyle()
    }
}
