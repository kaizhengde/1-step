//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @ObservedObject var viewModel: GoalEnterInputModel
    @StateObject private var miniSheetManager = MiniSheetManager.shared
    
    let selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            OneSTextField(input: $viewModel.selectedData.goalName, placeholder: "Meditate", inputColor: selectedColor.get(), inputLimit: Goal.nameDigitsLimit)
            
            HStack {
                OneSTextField(input: $viewModel.selectedData.stepsNeeded, placeholder: "100", inputColor: selectedColor.get(), inputLimit: Goal.stepsNeededDigitsLimit, keyboard: .numberPad)
                    
                OneSFillButton(text:        viewModel.stepEnterUnitButtonText(),
                               textFont:    .custom(weight: Raleway.bold, size: 20),
                               textColor:   .whiteToDarkGray,
                               buttonColor: viewModel.stepEnterUnitButtonColor(selectedColor),
                               width:       140*Layout.multiplierWidth,
                               height:      70
                ) {
                    miniSheetManager.showCustomMiniSheet(titleText: "Select Unit", backgroundColor: selectedColor.get(), height: 500*Layout.multiplierHeight) {
                        GoalEnterInputSelectStepUnitView(viewModel: viewModel, selectedColor: selectedColor)
                    }
                }
            }
        }
        .frame(height: 200*Layout.multiplierHeight)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
