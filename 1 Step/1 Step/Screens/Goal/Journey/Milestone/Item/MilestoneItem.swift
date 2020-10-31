//
//  MilestoneItem.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

struct MilestoneItem: View {
    
    var goal: Goal
    var milestone: Milestone
    
    @State private var appearDot: Bool = false
    @State private var tapAnimation: Bool = false

    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: goal, milestone: milestone)
                .scaleEffect(tapAnimation ? 1.05 : 1.0)
                .onTapGesture {
                    tapAnimation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
                }
            
            if milestone.state == .active {
                MilestoneDotView(goal: goal)
                    .opacity(appearDot ? 1.0 : 0.0)
            } else {
                Color.clear.frame(height: 15)
            }
        }
        .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { self.appearDot = true } }
    }
    
    
    private struct ItemView: View {
        
        var goal: Goal
        var milestone: Milestone
        
        
        var body: some View {
            VStack(spacing: 10) {
                milestone.image.get()
                    .font(.system(size: 50, weight: .ultraLight))
                    .foregroundColor(.backgroundStatic)
                
                HStack {
                    Spacer()
                    Text(milestone.neededStepUnits.toUI())
                        .font(.custom(Raleway.extraBold, size: 24))
                    +
                    Text(" ").font(.system(size: 5))
                    +
                    Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                        .font(.custom(Raleway.extraBold, size: 18))
                    Spacer()
                }
                .foregroundColor(.backgroundStatic)
            }
            .padding(8)
            .frame(width: milestone.state == .done ? 230 : 140, height: 160)
            .background(goal.color.get(milestone.state == .active ? .dark : .light))
            .cornerRadius(8)
            .contentShape(Rectangle())
            .oneSShadow(opacity: 0.15, y: 3, blur: 10)
            .overlay(
                Group {
                    if milestone.state == .done {
                        VStack {
                            HStack {
                                Spacer()
                                SFSymbol.checkmark
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(goal.color.get(.dark))
                                    .padding(20)
                            }
                            Spacer()
                        }
                    }
                }
            )
        }
    }
}

