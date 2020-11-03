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
    
    #warning("The Problem is: Alignment to Bottom of Milestone is not equal to y position from preferences. I need to adjust with the right amount to fix this issue!")
    #warning("For the first milestone I could just set the alignment not to the last item but to the first step. That way it would start inside and give the appropriate look")
    #warning("For the animation part the rectangle background animation or with other words the removing of extra steps to make the whole thing smaller has to come delayed after the increase animation. Otherwise we would just stand still at the current point and do nothing.")
    #warning("The milestone item change animation weird offset I think comes from the dragging part, that way there is this strange y offset. I think I can fixed that quite easily by just switching clearly with the animation, to have a new animation for that. But I don't know if thats as easy to do.")
    #warning("To make everything clean everything should go inside the journeyModel for sure.")
    #warning("Other than that there isn't really much else to say!")
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .currentCircleTextAlignment, vertical: .top)) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10)
                .frame(height: abs(viewModel.currentStepPosition.y-(viewModel.milestoneRects[lastMilestone.objectID]?.maxY ?? 0)))
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
            .offset(y: -25)
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
