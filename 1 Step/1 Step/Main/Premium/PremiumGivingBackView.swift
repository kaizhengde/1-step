//
//  PremiumGivingBackView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.01.21.
//

import SwiftUI

struct PremiumGivingBackView: View {
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView(Localized.givingBack, trailingButton: (.close, .grayToBackground, { SheetManager.shared.dismiss() }), isInsideSheet: true)
                    
                    OneSTextPassage(passageData: [
                        OneSTextPassageData(text: Localized.GivingBack.textPassage1, textArt: .standard),
                        OneSTextPassageData(text: Localized.GivingBack.textPassage2, textArt: .background)
                    ])
                    
                    GivingBackImageView()
                        .offset(y: -32)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.bottom, 100*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct GivingBackImageView: View {
        
        var body: some View {
            Photo.givingBack
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Layout.firstLayerWidth, height: 200)
                .cornerRadius(12)
                .oneSShadow(opacity: 0.05, blur: 10)
                .oneSItemScaleTapGesture()
                .oneSItemTransition()
        }
    }
}
