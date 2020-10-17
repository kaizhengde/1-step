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
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                OneSSecondaryHeaderText(text: "Goals", color: .grayToBackground)
                
                VStack(spacing: 20) {
                    ForEach(dataModel.activeGoals, id: \.self) { goal in
                        GoalItem(goalActiveModel: GoalsActiveModel(), goal: goal) {
                            goalModel.selectedGoal = goal
                            goalModel.dragState = .none
                        }
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
}
