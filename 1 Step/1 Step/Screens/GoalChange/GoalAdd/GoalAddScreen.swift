//
//  GoalsAddScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalAddScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var viewModel = GoalAddModel()
    @StateObject private var goalSelectMountainModel = GoalSelectMountainModel()
    
    
    var body: some View {
        ZStack {
            VStack {
                OneSHeaderView(trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) }))
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            
            viewModel.goalAddStage == .selectMountain ?
            GoalSelectMountainView(viewModel: goalSelectMountainModel)
            : nil
            
            viewModel.goalAddStage == .enterInput ?
            GoalEnterInputView()
            : nil
        }
        .onAppear {
            goalSelectMountainModel.delegate = viewModel
        }
    }
}



