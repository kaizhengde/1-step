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
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                ZStack {
                    GoalHeaderView()
                    goalModel.selectedGoal.color.get().offset(y: Layout.screenHeight + 20)
                    GoalSummaryView() 
                }
            }
        }
        .transition(.identity)
        .onAppear { goalModel.initTransition() }
    }
}
