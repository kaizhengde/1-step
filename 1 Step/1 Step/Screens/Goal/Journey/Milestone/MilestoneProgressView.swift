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
    @StateObject private var journeyAnimationHandler = JourneyAnimationHandler.shared
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    
    @State private var show: Bool = true
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .circleLineAlignment)) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .frame(width: 12, height: show ? viewModel.lineHeight : 0)
                .foregroundColor(.backgroundToGray)
            
            VStack(spacing: 16) {
                OneSText(text: viewModel.goal.currentStepUnits.toUI(), font: .custom(weight: Raleway.extraBold, size: 70), color: .backgroundToGray)
                
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.backgroundToGray)
                    .oneSShadow(opacity: 0.15, y: 0, blur: 0.2)
                    .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.2 : 1.0)
                    .alignmentGuide(.circleLineAlignment) { $0[VerticalAlignment.center] }
                    .animation(InfiniteAnimationManager.slowAnimation)
                    .opacity(show ? 1.0 : 0.0)
                    .scaleEffect(show ? 1.0 : 0.9)
            }
        }
        .onChange(of: journeyAnimationHandler.milestoneChangeState) {
            if $0 == .closeFinished {
                show = false
            } else if $0 == .openNewAndScrollToCurrent {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { show = true }
            }
        }
    }
}
