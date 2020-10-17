//
//  GoalScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

struct GoalScreen: View {
    
    @EnvironmentObject var goalModel: GoalModel
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            GoalMenuView()
            GoalView()
        }
        .transition(.identity)
        .onAppear { goalModel.initTransition() }
        .highPriorityGesture(goalModel.dragMenu)
        .oneSAnimation()
    }
}


