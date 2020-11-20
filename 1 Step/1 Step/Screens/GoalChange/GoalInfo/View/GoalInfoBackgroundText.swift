//
//  OneSBackgroundText.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct GoalInfoBackgroundText: View {
    
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
                    .font(.custom(Raleway.semiBold, size: big ? 20 : 15))
                    .foregroundColor(.backgroundToGray)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(Layout.firstLayerPadding)
            .frame(width: 250*Layout.multiplierWidth)
            .frame(maxHeight: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .oneSItemTransition()
            
            Spacer()
        }
    }
}
