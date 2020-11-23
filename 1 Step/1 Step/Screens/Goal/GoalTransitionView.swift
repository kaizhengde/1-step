//
//  GoalTransitionView.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

struct GoalTransitionView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var goalReachedModel = GoalReachedModel.shared
    
    
    var body: some View {
        Color.backgroundToGray
            .edgesIgnoringSafeArea(.all)
            .oneSShadow(opacity: 0.2, y: 0, blur: 13)
            .transition(AnyTransition.move(edge: .trailing))
            .oneSAnimation()
            .onAppear {
                goalModel.initAppear()
                goalReachedModel.initAppear()
            }
    }
}
