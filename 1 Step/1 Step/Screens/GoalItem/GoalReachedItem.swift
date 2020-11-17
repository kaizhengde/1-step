//
//  GoalReachedItem.swift
//  1 Step
//
//  Created by Kai Zheng on 17.11.20.
//

import SwiftUI

struct GoalReachedItem: View {
    
    @State private var tapAnimation: Bool = false
    
    var goal: Goal
    let onTap: () -> ()
    
        
    var body: some View {
        ZStack {
            MountainView(goal: goal)
            TextView(goal: goal)
        }
        .frame(width: 260*Layout.multiplierWidth, height: 165*Layout.multiplierWidth)
        .background(goal.color.get())
        .clipShape(GoalItemArt.shape)
        .contentShape(GoalItemArt.shape)
        .oneSShadow(opacity: 0.15, y: 3, blur: 10)
        .scaleEffect(tapAnimation ? 1.05 : 1.0)
        .onTapGesture {
            onTap()
            tapAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
        }
    }
    
    
    private struct TextView: View {
        
        var goal: Goal
        
        
        var body: some View {
            HStack {
                VStack {
                    VStack(alignment: .leading) {
                        OneSText(text: goal.name, font: GoalItemArt.nameFont, color: .backgroundToGray)
                        
                        HStack {
                            Text("\(goal.neededStepUnits)")
                            +
                            Text(" ").font(.system(size: 5))
                            +
                            Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                            Spacer()
                        }
                        .font(GoalItemArt.stepsFont.get())
                        .foregroundColor(.backgroundToGray)
                        .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    HStack {
                        SFSymbol.rosette
                            .font(.system(size: 30, weight: .regular))
                            .frame(width: 50, height: 50, alignment: .bottomLeading)
                            .foregroundColor(.backgroundToGray)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 20)
            .frame(width: 260*Layout.multiplierWidth, height: 150*Layout.multiplierWidth)
        }
    }
    
    
    private struct MountainView: View {
        
        var goal: Goal
        
        
        var body: some View {
            HStack {
                Spacer()
                ZStack(alignment: .init(horizontal: .flagMountainAlignment, vertical: .top)) {
                    goal.mountain.get()
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.white)
                        .colorMultiply(.backgroundToGray)
                    
                    Flag.flag
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .colorMultiply(.backgroundToGray)
                        .alignmentGuide(.flagMountainAlignment) { $0[.leading] }
                        .offset(y: -40)
                }
                .frame(width: GoalItemArt.width)
                .offset(y: 120*Layout.multiplierWidth)
            }
        }
    }
}
