//
//  GoalMenuView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalMenuView: View {
    
    @StateObject private var dataModel = DataModel.shared
    @EnvironmentObject var goalModel: GoalModel
    
    var activeGoalsRest: [Goal] { dataModel.activeGoals.filter { $0 != goalModel.selectedGoal }}
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                OneSSecondaryHeaderText(text: "Goals", color: .grayToBackground)
                
                VStack(spacing: 5) {
                    GoalMenuItem(goal: $goalModel.selectedGoal)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: GoalItemArt.width/1.3, height: 4)
                        .foregroundColor(goalModel.selectedGoal.color.get())
                }
                .padding(.bottom, 12)
                
                VStack(spacing: 20) {
                    ForEach(activeGoalsRest, id: \.self) { goal in
                        GoalMenuItem(goal: .constant(goal))
                    }
                }
            }
            .padding(.vertical, 50)
            .padding(.bottom, 80)
        }
        .frame(width: goalModel.menuWidth)
        .offset(x: goalModel.menuDragOffset)
        .opacity(goalModel.viewDragOpacity)
    }
    
    
    private struct GoalMenuItem: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @Binding var goal: Goal
        
        
        var body: some View {
            GoalItem(goalActiveModel: GoalsActiveModel(), goal: $goal) {
                goalModel.selectedGoal = goal
                goalModel.dragState = .none
                goalModel.dragOffset = .zero
            }
        }
    }
}
