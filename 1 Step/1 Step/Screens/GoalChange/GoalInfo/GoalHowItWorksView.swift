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
            
            ScrollView {
                LazyVStack(spacing: 26) {
                    OneSHeaderView("How it works", trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }))
                    
                    LazyVStack(spacing: 20) {
                        OneSMultilineText(text: "When it comes down to reaching a goal, one of the most important things is actually the formulation.")
                        
                        OneSMultilineText(text: "Even more - having a intelligent formulation for your goal will pretty much decide, whether you succeed or not.")
                        
                        OneSMultilineText(text: "In the following, we will show you a proven strategy that will get you an excellent formulation.", bold: true)
                        
                        OneSMultilineText(text: "This strategy has brought surprising success to thousands of people world wide. The concept is simple, here is how it works:")
                        
                        OneSBackgroundMultilineText(text: "It’s all about tiny steps you can take and track. The key is to be specific.")
                            .padding(.vertical, 20)
                    }
                    
                    LazyVStack(spacing: 10) {
                        OneSText(text: "I want to...", font: .custom(weight: Raleway.semiBold, size: 20), color: .grayToBackground)
                            .frame(width: Layout.firstLayerWidth, alignment: .leading)
                        
                        GoalInfoBackgroundText(text: "Lose weight", backgroundColor: UserColor.user0.get(), big: true)
                        GoalInfoArrowText(text: "What?", big: true)
                        
                        GoalInfoBackgroundText(text: "Lose 20 pounds", backgroundColor: UserColor.user0.get(), big: true)
                        GoalInfoArrowText(text: "How?", big: true)
                        
                        GoalInfoBackgroundText(text: "Exercise more often", backgroundColor: UserColor.user0.get(), big: true)
                        GoalInfoArrowText(text: "What?", big: true)
                        
                        GoalInfoBackgroundText(text: "Go for a run regularly", backgroundColor: UserColor.user0.get(), big: true)
                        GoalInfoArrowText(text: "What?", big: true)
                        
                        GoalInfoBackgroundText(text: "Run 100 miles in total", backgroundColor: UserColor.user0.get(.light), big: true)
                    }
                    .padding(.bottom, 20)
                    
                    LazyVStack(spacing: 20) {
                        OneSMultilineText(text: "Basically all we do is to continually ask ourselves how we can specify what it is that we want to achieve and how we can actually get there.")
                        
                        OneSMultilineText(text: "The main idea is then to reach a point where we have something that is trackable. Hence we can now take tiny steps to move closer and closer towards our goal.")
                        
                        OneSBackgroundMultilineText(text: "Sure, you can be as creative as you want. Choose whatever motivates you the most!")
                            .padding(.vertical, 20)
                    }
                    
                    LazyVStack(spacing: 10) {
                        GoalInfoBackgroundText(text: "Go for a run regularly", backgroundColor: UserColor.user0.get(), big: true)
                        GoalInfoArrowText(text: "What?", big: true)
                        
                        GoalInfoBackgroundText(text: "Run 100 miles in total", backgroundColor: UserColor.user0.get(.light), big: true)
                        GoalInfoBackgroundText(text: "Run for 300 times", backgroundColor: UserColor.user0.get(.light), big: true)
                        GoalInfoBackgroundText(text: "Run to 50 parks in town", backgroundColor: UserColor.user0.get(.light), big: true)
                        GoalInfoBackgroundText(text: "Hike 12 mountains in the swiss alps", backgroundColor: UserColor.user0.get(.light), big: true)
                    }
                    .padding(.bottom, 20)
                    
                    LazyVStack(spacing: 20) {
                        OneSMultilineText(text: "And that’s it, simple right?", bold: true)
                    }
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.top, 12)
                .padding(.bottom, 300*Layout.multiplierHeight)
            }
        }
    }
}
