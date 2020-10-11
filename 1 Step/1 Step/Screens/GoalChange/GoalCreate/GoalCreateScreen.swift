//
//  GoalsAddScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalCreateScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var viewModel = GoalCreateModel()
    @StateObject private var goalSelectMountainModel = GoalSelectMountainModel()
    @StateObject private var goalEnterInputModel = GoalEnterInputModel()
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 16*Layout.multiplierHeight) {
                GoalCreateHeaderView(viewModel: viewModel)
                
                if viewModel.goalCreateStage == .enterInput {
                    GoalEnterInputView(viewModel: goalEnterInputModel, selectedColor: viewModel.selectedMountainData.color)
                    
                    HStack {
                        Spacer()
                        OneSContinueButton(color: .grayToBackground) { viewModel.tryCreateGoalAndDismiss() }
                    }
                    .offset(y: 20*Layout.multiplierHeight)
                }
                
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            
            if viewModel.goalCreateStage == .selectMountain {
                GoalSelectMountainView(viewModel: goalSelectMountainModel)
            }
        }
        .onAppear {
            goalSelectMountainModel.delegate = viewModel
            goalEnterInputModel.delegate = viewModel
        }
    }
    
    
    private struct GoalCreateHeaderView: View {
        
        @StateObject private var mainModel = MainModel.shared
        @ObservedObject var viewModel: GoalCreateModel
        
        
        var body: some View {
            ZStack(alignment: .top) {
                OneSHeaderView(trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) }))
                
                VStack(spacing: 12*Layout.multiplierHeight) {
                    OneSHeaderView("Create", leadingButton: (.back, viewModel.selectedMountainData.color.get(), { viewModel.goalCreateStage = .selectMountain }))
                    HStack {
                        OneSHintButton(text: "How it works", color: viewModel.selectedMountainData.color.get()) {}
                        Spacer()
                    }
                    .offset(x: 3)
                }
                .opacity(viewModel.backButtonOpacity)
            }
        }
    }
}



