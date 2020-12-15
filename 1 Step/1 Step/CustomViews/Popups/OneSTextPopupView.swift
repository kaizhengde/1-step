//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopupView: View {

    @StateObject private var manager = PopupManager.shared
    
    let titleText: String
    let titleImage: Image?
    let bodyText: String
    let textColor: Color
    let bottomBtnTitle: String
    
    
    init(titleText: String,
         titleImage: Image?     = nil,
         bodyText: String,
         textColor: Color       = .backgroundToGray,
         bottomBtnTitle: String = Localized.ok
    ) {
        self.titleText      = titleText
        self.titleImage     = titleImage
        self.bodyText       = bodyText
        self.textColor      = textColor
        self.bottomBtnTitle = bottomBtnTitle
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .bottom) {
                    OneSSecondaryHeaderText(text: titleText, color: textColor)
                    if let titleImage = titleImage {
                        titleImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                }
                
                OneSMultilineText(text: bodyText, color: textColor)
                
                Spacer()
                
                HStack {
                    OneSBorderButton(text: bottomBtnTitle, color: textColor) { manager.dismiss() }
                        .offset(y: -12)
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, titleImage == nil ? 20 : 0)
    }
}
