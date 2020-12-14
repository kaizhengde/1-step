//
//  GoalExampleBackgroundText.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct GoalExampleBackgroundText: View {
    
    let text: String
    let backgroundColor: Color
    let big: Bool
    
    init(text: String, backgroundColor: Color, big: Bool = false) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.big = big
    }
    
    
    var body: some View {
        HStack {
            HStack {
                Text(text)
                    .font(.custom(Raleway.semiBold.weight, size: big ? 20 : 17))
                    .foregroundColor(.backgroundToGray)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.vertical, big ? 18 : 15)
            .frame(width: 250*Layout.multiplierWidth)
            .frame(maxHeight: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .oneSItemTransition()
            
            Spacer()
        }
    }
}
