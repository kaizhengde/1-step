//
//  MilestoneDotView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneDotView: View {
    
    @State private var appear = false
    
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
    
    var appearAfter: DispatchTimeInterval
    
    
    var body: some View {
        Group {
            if milestone.state != .current {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(goal.color.get(.dark))
                    //.scaleEffect(appear ? 1.0 : 0.9)
                    //.opacity(appear ? 1.0 : 0.0)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + appearAfter) { self.appear = true }
        }
    }
}
