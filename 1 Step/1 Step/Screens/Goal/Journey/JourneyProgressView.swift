//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct JourneyProgressView: View {
    
    var goal: Goal
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .currentCircleTextAlignment, vertical: .top)) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10)
                .frame(maxWidth: .infinity)
                .foregroundColor(.backgroundToGray)

            
            HStack(spacing: 16) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.backgroundToGray)
                    .oneSShadow(opacity: 0.1, y: 3, blur: 0.15)
                    .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.3 : 1.0)
                    .id(GoalModel.ScrollPosition.current)
                    .alignmentGuide(.currentCircleTextAlignment) { $0[HorizontalAlignment.center] }
               
                
                OneSText(text: goal.currentStepUnits.toUI(), font: .custom(weight: Raleway.extraBold, size: 48), color: .backgroundToGray)
            }
            .offset(y: -25)
        }
        .alignmentGuide(.progressCurrentAlignment) { $0[.top] }
        .animation(InfiniteAnimationManager.slowAnimation)
    }
}
