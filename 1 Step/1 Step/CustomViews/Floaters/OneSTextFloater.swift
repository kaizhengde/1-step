//
//  OneSTextFloater.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextFloater: View {
    
    let titleText: String
    let bodyText: String
    let backgroundColor: Color
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                OneSText(text: titleText, font: .title2, color: .backgroundToGray)
                OneSText(text: bodyText, font: .footnote, color: .backgroundToGray)
            }
            Spacer()
        }
        .padding(Layout.firstLayerPadding)
        .frame(width: Layout.floaterWidth, height: Layout.floaterHeight)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}
