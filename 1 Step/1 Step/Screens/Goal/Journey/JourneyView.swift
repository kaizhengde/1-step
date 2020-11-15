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
            LazyVStack(spacing: 60) {
                MilestoneViewGroup(viewModel: viewModel, milestone: viewModel.summitMilestone) {
                    SummitMilestoneItem(milestone: viewModel.summitMilestone)
                }
                .padding(.bottom, 20)
                
                ForEach(viewModel.milestonesUI, id: \.self) { milestone in
                    MilestoneViewGroup(viewModel: viewModel, milestone: milestone) {
                        MilestoneItem(milestone: milestone)
                    }
                }
            }
        }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @ObservedObject var viewModel: JourneyModel
        @State private var appear = false
        
        var milestone: Milestone
        let itemView: () -> Content
        
        
        var body: some View {
            ZStack {
                if milestone.state == .current {
                    ZStack(alignment: .top) {
                        MilestoneView()
                            .padding(.top, viewModel.currentMilestone === viewModel.summitMilestone ? 200 : 100)
                        itemView()
                    }
                } else {
                    itemView()
                }
            }
            .scaleEffect(appear ? 1.0 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
            .onAppear { appear = true }
        }
    }
}
