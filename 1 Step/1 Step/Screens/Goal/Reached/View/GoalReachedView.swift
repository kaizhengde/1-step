//
//  GoalReachedView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

struct GoalReachedView: View {
    
    @StateObject private var goalReachedModel = GoalReachedModel.shared

    
    var body: some View {
        Group {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .top) {
                    GoalReachedHeaderView()
                    
                    Group {
                        goalReachedModel.selectedGoal.color.get().offset(y: Layout.screenHeight + 20)
                        VStack {
                            GoalReachedSummaryView()
                            JourneyView(state: .reached)
                                .offset(y: -250)
                        }
                    }
                }
            }
        }
    }
}
