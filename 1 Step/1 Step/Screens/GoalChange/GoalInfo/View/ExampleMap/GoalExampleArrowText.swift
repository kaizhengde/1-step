//
//  GoalExampleArrowText.swift
//  1 Step
//
//  Created by Kai Zheng on 17.11.20.
//

import SwiftUI

struct GoalExampleArrowText: View {
    
    let text: String
    let big: Bool
    
    init(text: String, big: Bool = false) {
        self.text = text
        self.big = big
    }
    
    
    var body: some View {
        HStack {
            Symbol.longArrowDown
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: big ? 60 : 40)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .colorMultiply(.neutralToDarkNeutral)
            
            OneSText(text: text, font: .custom(weight: Raleway.medium, size: 17), color: .grayToBackground)
            
            Spacer()
        }
        .padding(.leading, Layout.firstLayerPadding)
        .oneSItemTransition()
    }
}
