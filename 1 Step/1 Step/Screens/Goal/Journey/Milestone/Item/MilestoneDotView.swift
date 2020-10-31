//
//  MilestoneDotView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneDotView: View {
    
    var goal: Goal
    
    
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(goal.color.get(.dark))
    }
}
