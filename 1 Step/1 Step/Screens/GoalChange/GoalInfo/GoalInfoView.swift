//
//  GoalInfoView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

struct GoalInfoView: View {
    
    @StateObject private var sheetManager = SheetManager.shared
    @StateObject private var viewModel = GoalInfoModel()
    
    let selectedColor: UserColor
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                ScrollViewReader { scrollProxy in
                    Color.clear.frame(height: 0).id(0)
                    
                    VStack(spacing: 32) {
                        OneSHeaderView(viewModel.currentView.title, leadingButton: viewModel.currentView == .examples ? (.back, .grayToBackground, { viewModel.currentView = .howItWorks }) : nil, trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }))
                        
                        if viewModel.currentView == .howItWorks {
                            Group {
                                GoalHowItWorksView(viewModel: viewModel, selectedColor: selectedColor)
                                
                                HStack {
                                    Spacer()
                                    OneSSmallBorderButton(symbol: SFSymbol.arrow, color: .grayToBackground) {
                                        withAnimation { scrollProxy.scrollTo(0) }
                                        viewModel.currentView = .examples
                                    }
                                }
                            }
                            .opacity(viewModel.currentView == .howItWorks ? 1.0 : 0.0)
                            
                        } else if viewModel.currentView == .examples {
                            GoalExamplesView(viewModel: viewModel, selectedColor: selectedColor)
                                .opacity(viewModel.currentView == .examples ? 1.0 : 0.0)
                        }
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .padding(.top, 12)
                    .padding(.bottom, 80*Layout.multiplierHeight)
                }
            }
        }
        .oneSAnimation()
    }
}
