//
//  GoalEditScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct GoalEditScreen: View {
    
    @StateObject private var goalModel = GoalModel.shared
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
                        OneSHeaderView(
                            Localized.edit,
                            trailingButton:         (.close, .grayToBackground, { sheetManager.dismiss() }),
                            secondaryButtonTop:     (.save, { viewModel.trySaveEditAndDismiss(goalModel.selectedGoal) }),
                            secondaryButtonBottom:  (.delete, { viewModel.tryDelete(goalModel.selectedGoal) }),
                            isInsideSheet:          true
                        )
                        
                        GoalEnterInputView(viewModel: goalEnterInputModel, selectedColor: $viewModel.selectedMountainData.color)
                        
                        GoalChangeNotificationView(goalEditModel: viewModel)
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    
                    GoalSelectMountainView(viewModel: goalSelectMountainModel)
                }
            }
        }
        .onAppear { setUpChangeViews() }
        .onReceive(PopupManager.shared.confirmBtnDismissed) { if $0.key == .goalDelete { viewModel.deleteGoalAndDismiss(goalModel.selectedGoal) } }
    }
    
    
    private func setUpChangeViews() {
        goalSelectMountainModel.delegate                    = viewModel
        goalEnterInputModel.delegate                        = viewModel
        
        let goal                                            = goalModel.selectedGoal!
        
        goalEnterInputModel.selectedData.goalName           = goal.name
        goalEnterInputModel.selectedData.neededStepUnits    = String(goal.neededStepUnits)
        goalEnterInputModel.selectedData.stepUnit           = goal.step.unit
        goalEnterInputModel.selectedData.customUnit         = goal.step.customUnit
        
        goalSelectMountainModel.currentMountain             = goal.mountain
        
        goalSelectMountainModel.selectedData.mountain       = goal.mountain
        goalSelectMountainModel.selectedData.color          = goal.color
    }
}
