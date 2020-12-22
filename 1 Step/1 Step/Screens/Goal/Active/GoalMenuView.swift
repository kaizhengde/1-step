//
//  GoalMenuView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalMenuView: View {
    
    @StateObject private var dataModel = DataModel.shared
    @StateObject private var goalModel = GoalModel.shared
    
    var activeGoalsRest: [Goal] { dataModel.activeGoals.filter { $0 != goalModel.selectedGoal } }
    

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                OneSText(text: Localized.goals, font: .custom(.extraBold, 33), color: .grayToBackground)
                
                VStack(spacing: 5) {
                    GoalMenuItem(goal: $goalModel.selectedGoal)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: GoalItemArt.width/1.3, height: 4)
                        .foregroundColor(goalModel.selectedGoal.color.standard)
                }
                .padding(.bottom, 12)
                
                VStack(spacing: 20) {
                    ForEach(activeGoalsRest, id: \.self) { goal in
                        GoalMenuItem(goal: .constant(goal))
                    }
                }
            }
            .frame(width: goalModel.menuWidth)
            .padding(.vertical, 50)
            .padding(.bottom, 80)
        }
        .offset(x: goalModel.menuDragOffset)
        .opacity(goalModel.viewDragOpacity)
    }
    
    
    private struct GoalMenuItem: View {
        
        @StateObject private var goalModel = GoalModel.shared
        @Binding var goal: Goal
        
        
        var body: some View {
            GoalItem(goalsGridModel: GoalsGridModel(tab: .active), goal: $goal) {
                goalModel.selectedGoal = goal
                goalModel.dragState = .none
                goalModel.dragOffset = .zero
            }
        }
    }
}
