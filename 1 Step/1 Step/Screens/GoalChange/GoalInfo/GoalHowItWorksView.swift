//
//  GoalHowItWorksView.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct GoalHowItWorksView: View {
    
    @StateObject private var sheetManager = SheetManager.shared
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    OneSHeaderView("How it works", trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }))
                    
                    OneSMultilineText(text: "When it comes down to reaching a goal, one of the most important things is actually the formulation.")
                    
                    OneSMultilineText(text: "Even more - having a intelligent formulation for your goal will pretty much decide, whether you succeed or not.")
                    
                    OneSMultilineText(text: "In the following, we will show you a proven strategy that will get you an excellent formulation.", bold: true)
                    
                    OneSMultilineText(text: "This strategy has brought surprising success to thousands of people world wide. The concept is simple, here is how it works:")
                    
                    OneSBackgroundMultilineText(text: "It’s all about tiny steps you can take and track. The key is to be specific.")
                        .padding(.vertical, 30)
                    
                    OneSText(text: "I want to...", font: .custom(weight: Raleway.semiBold, size: 20), color: .grayToBackground)
                        .frame(width: Layout.firstLayerWidth, alignment: .leading)
                    
                    GoalInfoBackgroundText(text: "Lose weight", backgroundColor: UserColor.user0.get(), big: true)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.top, 12)
                .padding(.bottom, 300*Layout.multiplierHeight)
            }
        }
    }
}
