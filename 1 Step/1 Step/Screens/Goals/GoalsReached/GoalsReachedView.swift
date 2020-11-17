//
//  GoalsReachedView.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct GoalsReachedView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var dataModel = DataModel.shared
    @ObservedObject var viewModel: GoalsReachedModel
    
    
    var body: some View {
        LazyVStack(spacing: 24) {
            ForEach(dataModel.reachedGoals, id: \.self) { goal in
                HStack {
                    GoalReachedItem(goal: goal) {}
                    Spacer()
                }
            }
        }
        .oneSMountainAnimation(response: 0.4, dampingFraction: 0.5)
    }
}
