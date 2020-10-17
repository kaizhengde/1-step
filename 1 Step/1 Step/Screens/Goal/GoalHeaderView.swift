//
//  GoalHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalHeaderView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    
    
    var body: some View {
        VStack {
            OneSHeaderView(leadingButton: (.custom(AnyView(MenuButton())), goalModel.selectedGoal.color.get(), {}), trailingButton: (.settings, goalModel.selectedGoal.color.get(), {}))
            Spacer()
        }
        .padding(.horizontal, Layout.firstLayerPadding)
        .opacity(goalModel.transition.didAppear ? 1.0 : 0.0)
        .offset(y: goalModel.transition.didAppear ? 0 : -30)
        .oneSAnimation()
    }
    
    
    private struct MenuButton: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        
        var body: some View {
            VStack {
                Rectangle()
                    .frame(width: 24, height: 5.5)
                    .rotationEffect(.zero)
                    .offset(y: 5)
                
                Rectangle()
                    .frame(width: 24, height: 5.5)
                    .rotationEffect(.zero)
                    .offset(y: 2)
            }
            .frame(width: 24, height: 24)
            .foregroundColor(goalModel.selectedGoal.color.get())
            .contentShape(Rectangle())
            .onTapGesture {}
        }
    }
}
