//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @ObservedObject var viewModel: GoalEnterInputModel
    @StateObject private var popupManager = PopupManager.shared
    let selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            OneSTextField(input: $viewModel.selectedData.goalName, placeholder: "Meditate", textFont: .header2, textColor: selectedColor.get(), textLimit: Goal.nameDigitsLimit)
            
            HStack {
                OneSTextField(input: $viewModel.selectedData.stepsNeeded, placeholder: "100", textFont: .header2, textColor: selectedColor.get(), textLimit: Goal.stepsNeededDigitsLimit, keyboard: .numberPad)
                    
                OneSFillButton(text: "times", textColor: .whiteToDarkGray, buttonColor: selectedColor.get(), width: 140*ScreenSize.multiplierWidth, height: 70) { print("Select Unit!") }
            }
        }
        .frame(height: 200*ScreenSize.multiplierHeight)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
