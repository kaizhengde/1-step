//
//  SummitMilestoneItem.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

struct SummitMilestoneItem: View {
    
    @Binding var goal: Goal
    var milestone: Milestone
    
    @State private var appearDotOne: Bool = false
    @State private var appearDotTwo: Bool = false
    @State private var tapAnimation: Bool = false
    
    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: $goal, milestone: milestone)
                .scaleEffect(tapAnimation ? 1.05 : 1.0)
                .onTapGesture {
                    tapAnimation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
                }
            
            if milestone.state == .active {
                VStack(spacing: 20) {
                    MilestoneDotView(goal: $goal)
                        .opacity(appearDotOne ? 1.0 : 0.0)
                    MilestoneDotView(goal: $goal)
                        .opacity(appearDotTwo ? 1.0 : 0.0)
                }
            } else {
                VStack(spacing: 20) {
                    Color.clear.frame(height: 15)
                    Color.clear.frame(height: 15)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { self.appearDotOne = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { self.appearDotTwo = true }
        }
    }
    
    
    private struct ItemView: View {
        
        @Binding var goal: Goal
        var milestone: Milestone
        
        
        var body: some View {
            VStack(spacing: 10) {
                milestone.image.get()
                    .font(.system(size: 60, weight: .ultraLight))
                    .foregroundColor(.backgroundStatic)
                    .padding(.bottom, 30)
                
                OneSSecondaryHeaderText(text: "Summit", color: .backgroundStatic)
                
                HStack {
                    Spacer()
                    Text(milestone.neededStepUnits.toUI())
                        .font(.custom(Raleway.regular, size: 18))
                    +
                    Text(" ").font(.system(size: 5))
                    +
                    Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                        .font(.custom(Raleway.regular, size: 14))
                    Spacer()
                }
                .foregroundColor(.backgroundStatic)
            }
            .padding(8)
            .frame(width: 170, height: 280)
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


