//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct MilestoneProgressView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @ObservedObject var viewModel: MilestoneModel
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .circleLineAlignment)) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .frame(width: 12, height: viewModel.lineHeight)
                .foregroundColor(.backgroundToGray)
            
            VStack(spacing: 16) {
                OneSText(text: viewModel.goal.currentStepUnits.toUI(), font: .custom(weight: Raleway.extraBold, size: 70), color: .backgroundToGray)
                
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.backgroundToGray)
                    .oneSShadow(opacity: 0.15, y: 0, blur: 0.2)
                    .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.3 : 1.0)
                    .id(GoalModel.ScrollPosition.current)
                    .alignmentGuide(.circleLineAlignment) { $0[VerticalAlignment.center] }
                    .animation(InfiniteAnimationManager.slowAnimation)
            }
        }
    }
}
