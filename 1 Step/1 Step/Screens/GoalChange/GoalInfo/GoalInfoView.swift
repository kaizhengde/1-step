//
//  GoalInfoView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

struct GoalInfoView: View {
    
    @StateObject private var sheetManager = SheetManager.shared
    @ObservedObject var viewModel: GoalInfoModel
    
    let selectedColor: UserColor
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: viewModel.currentView == .howItWorks ? true : false) {
                ScrollViewReader { scrollProxy in
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 0).id(0)
                        
                        VStack(spacing: 32) {
                            OneSHeaderView(
                                viewModel.currentView.title,
                                leadingButton:
                                    viewModel.currentView == .examples ? (
                                        viewModel.initialView == .howItWorks ?
                                            .back : .custom(AnyView(SFSymbol.info.font(.system(size: 28)))),
                                        .grayToBackground,
                                        { viewModel.currentView = .howItWorks }
                                    )
                                    : nil,
                                trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }),
                                isInsideSheet: true
                            )
                            
                            if viewModel.currentView == .howItWorks {
                                Group {
                                    GoalHowItWorksView(viewModel: viewModel, selectedColor: selectedColor)
                                    
                                    HStack {
                                        Spacer()
                                        OneSSmallBorderButton(symbol: SFSymbol.`continue`, color: .grayToBackground) {
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
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .padding(.bottom, (viewModel.currentView == .howItWorks ? 100 : 200)*Layout.multiplierHeight)
                }
            }
        }
        .oneSAnimation()
    }
}
