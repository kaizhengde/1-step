//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopup: View {
    
    let titleText: String
    let bodyText: String
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                OneSSecondaryHeaderText(text: titleText, color: .backgroundToGray)
                OneSText(text: bodyText, font: .body2, color: .backgroundToGray)
                Spacer()
            }
            Spacer()
        }
        .padding(Layout.firstLayerPadding)
        .padding(.vertical, 30)
        .frame(width: 240*ScreenSize.multiplierWidth, height: 320*ScreenSize.multiplierHeight)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}
