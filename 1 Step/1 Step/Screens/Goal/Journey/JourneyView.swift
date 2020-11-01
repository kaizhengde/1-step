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
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .milestoneAlignment)) {
            if let milestone = currentMilestone {
                ChildSizeReader(size: $viewModel.milestoneViewSize) {
                    MilestoneView(viewModel: MilestoneModel(goal: milestone.parentGoal, milestone: milestone))
                        .alignmentGuide(.milestoneAlignment) { $0[.top] }
                }
                .scaleEffect(viewModel.currentMilestoneAppear ? 1.0 : 0.9)
                .opacity(viewModel.currentMilestoneAppear ? 1.0 : 0.0)
            }
            
            VStack(spacing: 60) {
                MilestoneViewGroup(viewModel: viewModel, milestone: summitMilestone) { appear in
                    SummitMilestoneItem(appear: appear, milestone: summitMilestone)
                }
                .padding(.bottom, 20)
                
                ForEach(milestonesUI, id: \.self) { milestone in
                    MilestoneViewGroup(viewModel: viewModel, milestone: milestone) { appear in
                        MilestoneItem(appear: appear, milestone: milestone)
                    }
                }
            }
        }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: JourneyModel
        
        var milestone: Milestone
        let itemView: (Binding<Bool>) -> Content
        
        @State private var position: CGFloat = .zero
        @State private var appear = false
        
        
        var body: some View {
            ZStack {
                if milestone.state == .current {
                    itemView($appear)
                        .alignmentGuide(.milestoneAlignment) { $0[VerticalAlignment.center] }
                        .padding(.bottom, viewModel.milestoneViewSize.height-50)
                } else {
                    itemView($appear)
                }
            }
            .scaleEffect(appear ? 1.0 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear { position = proxy.frame(in: .journey).minY }
                        .onChange(of: viewModel.milestoneViewSize) { _ in position = proxy.frame(in: .journey).minY }
                }
            )
            .onChange(of: goalModel.scrollOffset) { offset in
                if offset+400*Layout.multiplierHeight > position {
                    appear = true
                    if milestone.state == .current { viewModel.currentMilestoneAppear = true }
                }
            }
        }
    }
}
