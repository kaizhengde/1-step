//
//  MilestoneDotView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneDotView: View {
    
    @Binding var milestoneAppear: Bool
    @State private var appear = false
    
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
    
    var appearAfter: DispatchTimeInterval
    var showEndDate: Bool
    
    init(milestoneAppear: Binding<Bool>, milestone: Milestone, appearAfter: DispatchTimeInterval, showEndDate: Bool = true) {
        self._milestoneAppear = milestoneAppear
        self.milestone = milestone
        self.appearAfter = appearAfter
        self.showEndDate = showEndDate
    }
    
    
    var body: some View {
        VStack {
            if milestone.state == .done && showEndDate {
                OneSText(text: milestone.endDate!.toDateString(), font: .custom(.extraBold, milestone.image == .summit ? 20 : 17), color: goal.color.dark)
                    .frame(width: 150)
            }
            if milestone.state != .current && !(milestone.image == .summit && milestone.state == .done && showEndDate) {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(goal.color.dark)
            }
        }
        .oneSItemTransition($appear)
        .onChange(of: milestoneAppear) {
            if $0 { DispatchQueue.main.asyncAfter(deadline: .now() + appearAfter) { self.appear = true } }
        }
        .onChange(of: AddStepAnimationHandler.shared.milestoneChangeState) { _ in appear = true  }
    }
}
