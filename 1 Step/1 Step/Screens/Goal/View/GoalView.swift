//
//  GoalView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    
    
    var body: some View {
        Group {
            Color.backgroundToGray
                .edgesIgnoringSafeArea(.all)
                .oneSShadow(opacity: 0.2, y: 0, blur: 13)
            
            ScrollView(showsIndicators: false) {
                ZStack {
                    GoalHeaderView()
                    
                    Group {
                        goalModel.backgroundColor.offset(y: Layout.screenHeight + 20)
                        GoalSummaryView()
                        GoalJourneyView()
                    }
                    .offset(x: goalModel.goalContentDragOffset)
                }
            }
            .opacity(goalModel.viewDragOpacity)
        }
        .offset(x: goalModel.goalDragOffset)
    }
}
