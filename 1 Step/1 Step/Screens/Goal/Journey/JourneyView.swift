//
//  JourneyView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct JourneyView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var viewModel = JourneyModel()
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 60) {
                MilestoneViewGroup(viewModel: viewModel, milestone: viewModel.summitMilestone) {
                    SummitMilestoneItem(appear: $0, milestone: viewModel.summitMilestone)
                }
                .padding(.bottom, 20)
                
                ForEach(viewModel.milestonesUI, id: \.self) { milestone in
                    MilestoneViewGroup(viewModel: viewModel, milestone: milestone) {
                        MilestoneItem(appear: $0, milestone: milestone)
                    }
                }
            }
        }
        .coordinateSpace(name: CoordinateSpace.journey)
        .onPreferenceChange(JourneyModel.MilestonePK.self) { viewModel.updateMilestonePositions($0) }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @ObservedObject var viewModel: JourneyModel
        
        var milestone: Milestone
        let itemView: (Binding<Bool>) -> Content
        
        var appear: Bool { viewModel.milestoneAppears[milestone.objectID] ?? false }
        
        
        var body: some View {
            ZStack {
                if milestone.state == .current {
                    ZStack(alignment: .top) {
                        MilestoneView()
                            .padding(.top, viewModel.currentMilestone === viewModel.summitMilestone ? 200 : 100)
                        itemView(Binding<Bool>(get: { appear }, set: { _ in }))
                    }
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
