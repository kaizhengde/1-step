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
    
    @Binding var selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            OneSTextField(input: $viewModel.selectedData.goalName, placeholder: Localized.meditate, inputColor: selectedColor.standard, inputLimit: Goal.nameDigitsLimit)
            
            HStack {
                OneSTextField(input: $viewModel.selectedData.neededStepUnits, placeholder: "30", inputColor: selectedColor.standard, inputLimit: Goal.neededStepUnitsDigitsLimit, keyboard: .numberPad)
                    
                OneSFillButton(text:        viewModel.stepEnterUnitButtonText(),
                               textFont:    .custom(.bold, 20),
                               textColor:   .whiteToDarkGray,
                               buttonColor: viewModel.stepEnterUnitButtonColor(selectedColor),
                               width:       140*Layout.multiplierWidth,
                               height:      70
                ) {
                    miniSheetManager.showCustomMiniSheet(backgroundColor: selectedColor.standard, height: 500*Layout.multiplierWidth) {
                        GoalEnterInputSelectStepUnitView(viewModel: viewModel, selectedColor: $selectedColor)
                    }
                }
            }
        }
        .frame(height: 200*Layout.multiplierHeight)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
