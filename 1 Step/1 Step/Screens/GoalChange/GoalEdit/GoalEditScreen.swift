//
//  GoalEditScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct GoalEditScreen: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel = GoalEditModel()
    @StateObject private var goalSelectMountainModel = GoalSelectMountainModel()
    @StateObject private var goalEnterInputModel = GoalEnterInputModel()
    @StateObject private var sheetManager = SheetManager.shared
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Group {
                        OneSHeaderView("Edit", trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }), secondaryButtonOuter: (.save, { viewModel.trySaveEditAndDismiss(goalModel.selectedGoal) }), secondaryButtonInner: (.delete, { viewModel.deleteGoalAndDismiss(goalModel.selectedGoal) }))
                        
                        GoalEnterInputView(viewModel: goalEnterInputModel, selectedColor: $viewModel.selectedMountainData.color)
                        
                        //Notification
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    
                    Spacer()
                    GoalSelectMountainView(viewModel: goalSelectMountainModel)
                }
                .padding(.top, 12)
            }
        }
        .onAppear { setUpChangeViews() }
    }
    
    
    private func setUpChangeViews() {
        goalSelectMountainModel.delegate = viewModel
        goalEnterInputModel.delegate = viewModel
        
        let goal = goalModel.selectedGoal!
        
        goalEnterInputModel.selectedData.goalName = goal.name
        goalEnterInputModel.selectedData.stepsNeeded = String(goal.stepsNeeded)
        goalEnterInputModel.selectedData.stepCategory = goal.step.category
        goalEnterInputModel.selectedData.stepUnit = goal.step.unit
        goalEnterInputModel.selectedData.stepCustomUnit = goal.step.customUnit
        
        goalSelectMountainModel.currentMountain = goal.mountain
        
        goalSelectMountainModel.selectedData.mountain = goal.mountain
        goalSelectMountainModel.selectedData.color = goal.color
    }
}
