//
//  GoalReachedHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

struct GoalReachedHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var goalReachedModel = GoalReachedModel.shared
    
    
    var body: some View {
        VStack {
            OneSHeaderView(trailingButton: (.close, goalReachedModel.selectedGoal.color.standard, {
                mainModel.toScreen(.goals)
            }))
            Spacer()
        }
        .padding(.horizontal, Layout.firstLayerPadding)
        .opacity(!goalReachedModel.transition.isFullHidden ? 1.0 : 0.0)
        .offset(y: !goalReachedModel.transition.isFullHidden ? 0 : -30)
        .oneSAnimation()
    }
}
