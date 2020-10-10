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
            //2. Rest
            VStack {
                //Header
                GoalCreateHeaderView(viewModel: viewModel)
                
                viewModel.goalCreateStage == .enterInput ?
                GoalEnterInputView(viewModel: goalEnterInputModel, selectedColor: viewModel.selectedMountainData.color)
                : nil
                
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            
            //1. Select Mountain + Color
            viewModel.goalCreateStage == .selectMountain ?
            GoalSelectMountainView(viewModel: goalSelectMountainModel)
            : nil
        }
        .onAppear { goalSelectMountainModel.delegate = viewModel }
    }
    
    
    private struct GoalCreateHeaderView: View {
        
        @StateObject private var mainModel = MainModel.shared
        @ObservedObject var viewModel: GoalCreateModel
        
        
        var body: some View {
            ZStack(alignment: .top) {
                OneSHeaderView(trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) }))
                
                VStack(spacing: 12*ScreenSize.multiplierHeight) {
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



