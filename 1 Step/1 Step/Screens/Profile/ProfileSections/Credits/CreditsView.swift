//
//  SpecialThanksView.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI

struct CreditsView: View {
    
    @StateObject private var viewModel = CreditsModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView(Localized.credits, trailingButton: (.close, .grayToBackground, { SheetManager.shared.dismiss() }), isInsideSheet: true)
                    
                    HStack {
                        OneSSecondaryHeaderText(text: Localized.thankYou, color: viewModel.color)
                        Spacer()
                    }
                    
                    CreditsContentView(viewModel: viewModel)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.bottom, 100*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct CreditsContentView: View {
        
        @ObservedObject var viewModel: CreditsModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<viewModel.credits.count) { i in
                    OneSDropDown(.shortBig, title: viewModel.credits[i].title) {
                        OneSBackgroundMultilineText(text: viewModel.credits[i].text, big: false)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
