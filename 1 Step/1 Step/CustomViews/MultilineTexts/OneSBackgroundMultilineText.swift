//
//  OneSBackgroundMultilineText.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct OneSBackgroundMultilineText: View {
    
    let text: String
    let big: Bool
    
    init(text: String, big: Bool = true) {
        self.text = text
        self.big = big
    }
    
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom(Raleway.regular.weight, size: big ? 20 : 17))
                .foregroundColor(.grayToBackground)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)
            
            Spacer()
        }
        .padding(Layout.firstLayerPadding)
        .frame(maxWidth: big ? .infinity : 280*Layout.multiplierWidth, maxHeight: .infinity)
        .background(big ? Color.darkBackgroundToDarkGray : Color.darkBackgroundToBlack)
        .cornerRadius(12)
    }
}
