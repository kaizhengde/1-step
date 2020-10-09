//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopup: View {
    
    let titleText: String
    let text: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                OneSSecondaryHeaderText(text: titleText)
                
                
            }
            .padding(Layout.firstLayerPadding)
            .frame(width: 260*ScreenSize.multiplierWidth, height: 400*ScreenSize.multiplierHeight)
        }
    }
}
