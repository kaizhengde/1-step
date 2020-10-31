//
//  MilestoneView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneView: View {
    
    @Binding var goal: Goal
    
    
    var body: some View {
        VStack {
            Color.clear
        }
        .frame(maxWidth: .infinity)
        .frame(height: 10000)
        .background(goal.color.get(.dark))
        .cornerRadius(20)
        .padding(.horizontal, Layout.firstLayerPadding)
        .padding(.vertical, 120)
    }
}
