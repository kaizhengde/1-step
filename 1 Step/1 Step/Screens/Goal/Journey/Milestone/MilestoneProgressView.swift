//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct MilestoneProgressView: View {
    
    @ObservedObject var viewModel: MilestoneModel
    @StateObject private var addStepAnimationHandler = AddStepAnimationHandler.shared
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    
    @State private var show: Bool = true
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .circleLineAlignment)) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .frame(width: 12, height: viewModel.lineHeight)
                .foregroundColor(.backgroundToDarkGray)
            
            VStack(spacing: 16) {
                OneSText(text: viewModel.goal.currentStepUnits.toUI(), font: .custom(.extraBold, 70), color: .backgroundToDarkGray)
                
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.backgroundToDarkGray)
                    .oneSShadow(opacity: 0.15, blur: 10)
                    .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.2 : 1.0)
                    .alignmentGuide(.circleLineAlignment) { $0[VerticalAlignment.center] }
                    .animation(InfiniteAnimationManager.slowAnimation)
                    .oneSItemTransition($show)
                    .oneSItemScaleTapGesture(amount: 1.2) { MilestoneModel.progressCircleTapped.send() }
                
                Color.clear.frame(height: 0)
                    .padding(.top, 150)
                    .id(GoalModel.ScrollPosition.current)
            }
            .padding(.bottom, -150)
        }
        .onChange(of: addStepAnimationHandler.milestoneChangeState) {
            if $0 == .closeFinished { show = false }
            else if $0 == .openNewAndScrollToCurrent {
                DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.oneS) { show = true }
            }
        }
    }
}
