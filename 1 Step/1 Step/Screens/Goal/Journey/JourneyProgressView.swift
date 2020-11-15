//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct JourneyProgressView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @ObservedObject var viewModel: JourneyModel
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    @State private var timer: Timer? = nil
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .currentCircleTextAlignment, vertical: .top)) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10)
                .frame(maxHeight: .infinity)
                .animation(InfiniteAnimationManager.slowAnimation)
                .foregroundColor(.backgroundToGray)
                .alignmentGuide(.currentAlignment) { $0[.top] }
                .animation(InfiniteAnimationManager.slowAnimation)
            
            HStack(spacing: 16) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.backgroundToGray)
                    .oneSShadow(opacity: 0.1, y: 3, blur: 0.15)
                    .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.3 : 1.0)
                    .id(GoalModel.ScrollPosition.current)
                    .alignmentGuide(.currentCircleTextAlignment) { $0[HorizontalAlignment.center] }

                OneSText(text: viewModel.goal.currentStepUnits.toUI(), font: .custom(weight: Raleway.extraBold, size: 48), color: .backgroundToGray)
            }
            .offset(y: -25)
        }
        .animation(InfiniteAnimationManager.slowAnimation)
    }
}
