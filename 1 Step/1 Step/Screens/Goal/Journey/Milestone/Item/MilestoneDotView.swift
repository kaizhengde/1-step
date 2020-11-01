//
//  MilestoneDotView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneDotView: View {
    
    @Binding var milestoneAppear: Bool
    
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
    
    var appearAfter: DispatchTimeInterval
    
    @State private var appear = false
    
    
    var body: some View {
        Group {
            if milestone.state == .active {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(goal.color.get(.dark))
                    .scaleEffect(appear ? 1.0 : 0.9)
                    .opacity(appear ? 1.0 : 0.0)
            } else {
                Color.clear.frame(height: 5)
            }
        }
        .onChange(of: milestoneAppear) {
            if $0 { DispatchQueue.main.asyncAfter(deadline: .now() + appearAfter) { self.appear = true } }
        }
    }
}
