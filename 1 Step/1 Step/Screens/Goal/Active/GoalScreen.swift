//
//  GoalScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

struct GoalScreen: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var addStepModel = AddStepModel()
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                GoalMenuView()
                GoalView()
            }
            .highPriorityGesture(goalModel.dragMenu)
            .onTapGesture { addStepModel.dragState = .hidden }
            
            AddStepView(viewModel: addStepModel)
        }
        .onAppear { goalModel.initTransition() }
        .oneSAnimation()
        .transition(.identity)
    }
}


