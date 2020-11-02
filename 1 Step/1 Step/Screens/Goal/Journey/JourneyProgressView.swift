//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct JourneyProgressView: View {
    
    @ObservedObject var viewModel: JourneyModel
    let goal: Goal
    let lastMilestone: Milestone
    
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .currentCircleTextAlignment, vertical: .top)) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10)
                .frame(height: abs(viewModel.currentStepPosition.y-(viewModel.milestonePositions[lastMilestone.objectID]?.y ?? 0))+220)
                .foregroundColor(.backgroundToGray)
                .alignmentGuide(.lineLastMilestoneAlignment) { $0[.bottom] }
            
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
        }
        .animation(InfiniteAnimationManager.slowAnimation)
    }
    
    
    private struct Line: Shape {

        var height: CGFloat

        var animatableData: CGFloat {
            get { height }
            set { height = newValue }
        }


        func path(in rect: CGRect) -> Path {
            var path = Path()

            path.move(to: .zero)
            path.addLine(to: CGPoint(x: .zero, y: height))

            return path
        }
    }
}
