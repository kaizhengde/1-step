//
//  GoalItem.swift
//  1 Step
//
//  Created by Kai Zheng on 12.10.20.
//

import SwiftUI

struct GoalItem: View {
    
    let goalActiveModel: GoalsActiveModel?
    @State private var isCurrentDrag: Bool = false
    @State private var tapAnimation: Bool = false
    
    let goal: Goal
    let onTap: () -> ()
    
        
    var body: some View {
        ZStack {
            MountainView(goal: goal)
            PercentView(goalActiveModel: goalActiveModel, goal: goal)
            TextView(goal: goal)
        }
        .frame(width: GoalItemArt.width, height: GoalItemArt.height)
        .background(GoalItemArt.color(isCurrentDrag, of: goal))
        .clipShape(GoalItemArt.shape)
        .contentShape(GoalItemArt.shape)
        .oneSShadow(opacity: 0.15, y: 3, blur: 10)
        .scaleEffect(tapAnimation ? 1.05 : 1.0)
        .onReceive(goalActiveModel!.$currentDragItem) { isCurrentDrag = $0 == goal }
        .onTapGesture {
            onTap()
            tapAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
        }
    }
    
    
    private struct PercentView: View {
        
        let goalActiveModel: GoalsActiveModel? 
        @State private var isCurrentDrag: Bool = false

        let goal: Goal
        
        
        var body: some View {
            GoalItemArt.current == .grid ?
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        OneSText(text: "\(goal.currentPercent)%", font: .subtitle, color: GoalItemArt.color(isCurrentDrag, of: goal))
                    }
                    .frame(width: 55, height: 30)
                    .background(Color.backgroundToGray)
                    .cornerRadius(10)
                }
                Spacer()
            }
            .padding([.horizontal, .top], 12)
            .onReceive(goalActiveModel!.$currentDragItem) { isCurrentDrag = $0 == goal }
            : nil
        }
    }
    

    private struct TextView: View {
        
        let goal: Goal
        
        
        var body: some View {
            VStack {
                VStack(alignment: .leading) {
                    OneSText(text: goal.name, font: GoalItemArt.nameFont, color: .backgroundToGray)
                    
                    HStack(spacing: 1.5) {
                        OneSText(text: "\(goal.stepsNeeded)", font: GoalItemArt.stepsFont, color: .backgroundToGray)
                        OneSText(text: GoalItemArt.stepUnitText(goal), font: GoalItemArt.stepsFont, color: .backgroundToGray)
                        Spacer()
                    }
                }
                .padding(12)
                .offset(y: GoalItemArt.textOffset)
                
                Spacer()
            }
        }
    }

    
    private struct MountainView: View {
        
        let goal: Goal
        
        
        var body: some View {
            goal.mountain.get()
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.white)
                .colorMultiply(.backgroundToGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: GoalItemArt.mountainOffset(goal))
        }
    }
}
