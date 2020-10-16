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
            GoalHeaderView()
        }
        .onAppear { goalModel.initTransition() }
    }
    
    
    private struct GoalHeaderView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        
        var body: some View {
            VStack {
                OneSHeaderView(leadingButton: (.custom(AnyView(Text("Test"))), goalModel.selectedGoal.color.get(), {}), trailingButton: (.settings, goalModel.selectedGoal.color.get(), {}))
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
        }
    }
}
