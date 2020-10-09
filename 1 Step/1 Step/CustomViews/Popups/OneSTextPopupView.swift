//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopupView: View {
    
    let titleText: String
    let titleImage : Image?
    let bodyText: String
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .bottom) {
                    OneSSecondaryHeaderText(text: titleText, color: .backgroundToGray)
                    if let titleImage = titleImage {
                        titleImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                }
                OneSText(text: bodyText, font: .body2, color: .backgroundToGray)
                Spacer()
            }
            Spacer()
        }
        .padding(Layout.firstLayerPadding)
        .padding(.vertical, 10)
        .padding(.top, titleImage == nil ? 20 : 0)
        .frame(width: 260*ScreenSize.multiplierWidth, height: 380*ScreenSize.multiplierHeight)
        .cornerRadius(20)
        .onAppear { print("Appear") }
        .onDisappear { print("Disappear") }
    }
}
