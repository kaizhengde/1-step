//
//  GoalReachedScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

struct GoalReachedScreen: View {
    
    @StateObject private var goalReachedModel = GoalReachedModel.shared
    
    
    var body: some View {
        ZStack {
            GoalReachedView()
        }
        .onAppear { goalReachedModel.initTransition() }
        .oneSAnimation()
        .transition(.identity)
    }
}
