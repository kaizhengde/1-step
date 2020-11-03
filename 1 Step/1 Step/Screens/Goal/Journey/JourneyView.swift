//
//  JourneyView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct JourneyView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel = JourneyModel()
    
    var milestonesUI: [Milestone] {
        Array(goalModel.selectedGoal.milestones)
            .sorted { $0.neededStepUnits > $1.neededStepUnits }
            .filter { $0.image != .summit }
    }
    
    var summitMilestone: Milestone {
        goalModel.selectedGoal.milestones.filter { $0.image == .summit }.first!
    }
    
    var currentMilestone: Milestone? {
        goalModel.selectedGoal.milestones.filter { $0.state == .current }.first
    }
    
    var currentMilestoneAppear: Bool {
        return viewModel.milestoneAppears[currentMilestone!.objectID] ?? false
    }
    
    var lastMilestone: Milestone { milestonesUI.last! }
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .milestoneAlignment)) {
            if let milestone = currentMilestone {
                ChildSizeReader(size: $viewModel.milestoneViewSize) {
                    MilestoneView(viewModel: MilestoneModel(goal: milestone.parentGoal, milestone: milestone))
                        .alignmentGuide(.milestoneAlignment) { $0[.top] }
                }
                .scaleEffect(currentMilestoneAppear ? 1.0 : 0.9)
                .opacity(currentMilestoneAppear ? 1.0 : 0.0)
            }
            
            ZStack(alignment: .init(horizontal: .currentCircleTextAlignment, vertical: .lineLastMilestoneAlignment)) {
                JourneyProgressView(viewModel: viewModel, goal: goalModel.selectedGoal, lastMilestone: lastMilestone)
                
                VStack(spacing: 60) {
                    MilestoneViewGroup(viewModel: viewModel, milestone: summitMilestone, lastMilestone: lastMilestone) {
                        SummitMilestoneItem(appear: $0, milestone: summitMilestone)
                    }
                    .padding(.bottom, 20)
                    
                    ForEach(milestonesUI, id: \.self) { milestone in
                        MilestoneViewGroup(viewModel: viewModel, milestone: milestone, lastMilestone: lastMilestone) {
                            MilestoneItem(appear: $0, milestone: milestone)
                        }
                    }
                }
            }
        }
        .coordinateSpace(name: CoordinateSpace.journey)
        .onPreferenceChange(JourneyModel.MilestonePK.self) { viewModel.updateMilestonePositions($0) }
        .onPreferenceChange(JourneyModel.StepPK.self) { viewModel.updateCurrentStepPosition($0) }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: JourneyModel
        
        var milestone: Milestone
        var lastMilestone: Milestone
        let itemView: (Binding<Bool>) -> Content
        
        var appear: Bool { viewModel.milestoneAppears[milestone.objectID] ?? false }
        
        
        var body: some View {
            ZStack {
                if milestone.state == .current {
                    itemView(Binding<Bool>(get: { appear }, set: { _ in }))
                        .alignmentGuide(.milestoneAlignment) { $0[VerticalAlignment.center] }
                        .padding(.bottom, viewModel.milestoneViewSize.height-50)
                } else if milestone === lastMilestone {
                    itemView(Binding<Bool>(get: { appear }, set: { _ in }))
                        .alignmentGuide(.lineLastMilestoneAlignment) { $0[.bottom] }
                } else {
                    itemView(Binding<Bool>(get: { appear }, set: { _ in }))
                }
            }
            .background(JourneyModel.MilestoneVS(milestone: milestone))
            .scaleEffect(appear ? 1.0 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
        }
    }
}
