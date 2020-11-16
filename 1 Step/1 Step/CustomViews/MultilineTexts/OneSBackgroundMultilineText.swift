//
//  OneSBackgroundMultilineText.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct OneSBackgroundMultilineText: View {
    
    let text: String
    
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom(Raleway.regular, size: 20))
                .foregroundColor(.grayToBackground)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)
        }
        .padding(Layout.firstLayerPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkBackgroundToDarkGray)
        .cornerRadius(12)
    }
}
