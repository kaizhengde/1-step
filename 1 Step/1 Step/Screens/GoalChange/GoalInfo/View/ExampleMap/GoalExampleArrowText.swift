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
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: big ? 42 : 36)
                .foregroundColor(.white)
                .colorMultiply(.darkNeutralToNeutral)
            
            OneSText(text: text, font: .custom(.medium, big ? 17 : 15), color: .grayToBackground)
            
            Spacer()
        }
        .padding(.leading, Layout.firstLayerPadding)
        .oneSItemTransition()
    }
}
