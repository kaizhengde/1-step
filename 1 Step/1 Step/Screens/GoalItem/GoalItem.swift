//
//  GoalItem.swift
//  1 Step
//
//  Created by Kai Zheng on 12.10.20.
//

import SwiftUI

struct GoalItem: View {
    
    let goalsGridModel: GoalsGridModel
    
    @State private var isCurrentDrag: Bool = false
    @Binding var goal: Goal
    let onTap: () -> ()
    
        
    var body: some View {
        ZStack {
            MountainView(goal: $goal)
            PercentView(goalsGridModel: goalsGridModel, goal: $goal)
            TextView(goal: $goal)
        }
        .frame(width: GoalItemArt.width, height: GoalItemArt.height, alignment: .top)
        .background(GoalItemArt.color(isCurrentDrag, of: goal))
        .clipShape(GoalItemArt.shape)
        .contentShape(GoalItemArt.shape)
        .oneSShadow(opacity: 0.15, y: 3, blur: 10)
        .onReceive(goalsGridModel.$currentDragItem) { isCurrentDrag = $0 == goal }
        .oneSItemScaleTapGesture(with: onTap)
    }
    
    
    private struct PercentView: View {
        
        let goalsGridModel: GoalsGridModel
        @State private var isCurrentDrag: Bool = false

        @Binding var goal: Goal
                
        
        var body: some View {
            GoalItemArt.current == .grid && goal.currentState == .active ?
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
            .padding([.horizontal, .top], GoalItemArt.padding)
            .onReceive(goalsGridModel.$currentDragItem) { isCurrentDrag = $0 == goal }
            : nil
        }
    }
    

    private struct TextView: View {
        
        @Binding var goal: Goal
                
        
        var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    OneSHyphenatedText(text: goal.name, font: GoalItemArt.nameFont, color: .backgroundToGray, width: GoalItemArt.textWidth)
                    
                    if GoalItemArt.current == .grid {
                        HStack {
                            Text("\(goal.neededStepUnits)")
                            +
                            Text(" ").font(.system(size: 5))
                            +
                            Text(goal.step.unitDescription)
                            Spacer()
                        }
                        .font(GoalItemArt.stepsFont.font)
                        .foregroundColor(.backgroundToGray)
                        .multilineTextAlignment(.leading)
                    } else {
                        HStack {
                            Text(goal.step.unitDescription)
                            Spacer()
                        }
                        .font(GoalItemArt.stepsFont.font)
                        .foregroundColor(.backgroundToGray)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding(GoalItemArt.padding)
                .offset(y: goal.currentState == .reached ? 24 : GoalItemArt.textOffset)
                .animation(nil)
                
                Spacer()
            }
        }
    }

    
    private struct MountainView: View {
        
        @Binding var goal: Goal
            
        
        var body: some View {
            ZStack(alignment: .init(horizontal: .flagMountainAlignment, vertical: .top)) {
                goal.mountain.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                    .colorMultiply(.backgroundToGray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if goal.currentState == .reached {
                    MountainImage.Flag.whole
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .colorMultiply(.backgroundToGray)
                        .alignmentGuide(.flagMountainAlignment) { $0[.leading] }
                        .offset(y: -24)
                }
            }
            .offset(y: GoalItemArt.mountainOffset(goal.currentPercent))
        }
    }
}
