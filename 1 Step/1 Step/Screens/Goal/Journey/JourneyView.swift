//
//  JourneyView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI
import CoreData

struct JourneyView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @State private var milestoneViewSize: CGSize = .zero
    
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
                ChildSizeReader(size: $milestoneViewSize) {
                    MilestoneView(goal: milestone.parentGoal, milestone: milestone)
                        .alignmentGuide(.milestoneAlignment) { $0[.top] }
                }
            }
            
            VStack(spacing: 60) {
                MilestoneViewGroup(milestone: summitMilestone, milestoneViewSize: milestoneViewSize) {
                    SummitMilestoneItem(goal: summitMilestone.parentGoal, milestone: summitMilestone)
                }
                .padding(.bottom, 20)
                
                ForEach(milestonesUI, id: \.self) { milestone in
                    MilestoneViewGroup(milestone: milestone, milestoneViewSize: milestoneViewSize) {
                        MilestoneItem(goal: milestone.parentGoal, milestone: milestone)
                    }
                }
            }
        }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        var milestone: Milestone
        var milestoneViewSize: CGSize
        let itemView: () -> Content
        
        @State private var milestonePositions: [NSManagedObjectID: CGFloat] = [:]
        @State private var appear = false
        
        
        var body: some View {
            ZStack {
                if milestone.state == .current {
                    itemView()
                        .alignmentGuide(.milestoneAlignment) { $0[VerticalAlignment.center] }
                        .padding(.bottom, milestoneViewSize.height-50)
                } else {
                    itemView()
                }
            }
            .scaleEffect(appear ? 1.0 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.clear)
                        .onAppear {
                            milestonePositions[milestone.objectID] = geometry.frame(in: .journey).minY
                        }
                }
            )
            .onChange(of: goalModel.scrollOffset) { offset in
                for position in milestonePositions {
                    if offset+400 > position.value { appear = true }
                }
            }
        }
    }
}
