//
//  GoalEnterInputView.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct GoalEnterInputView: View {
    
    @ObservedObject var viewModel: GoalEnterInputModel
    @StateObject private var floaterManager = FloaterManager.shared
    @StateObject private var popupManager = PopupManager.shared
    @StateObject private var miniSheetManager = MiniSheetManager.shared
    let selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            OneSTextField(input: $viewModel.selectedData.goalName, placeholder: "Meditate", textFont: .header2, textColor: selectedColor.get(), textLimit: Goal.nameDigitsLimit)
            
            HStack {
                OneSTextField(input: $viewModel.selectedData.stepsNeeded, placeholder: "100", textFont: .header2, textColor: selectedColor.get(), textLimit: Goal.stepsNeededDigitsLimit, keyboard: .numberPad)
                    
                OneSFillButton(text: "times", textColor: .whiteToDarkGray, buttonColor: selectedColor.get(), width: 140*Layout.multiplierWidth, height: 70) {
                    //floaterManager.showTextFloater(titleText: "Floater Test", bodyText: "This is just a test.", backgroundColor: selectedColor.get())
                    //popupManager.showTextPopup(titleText: "Popup Test", bodyText: "This is just a test.\n\nPlease just ignore me. Thank you!", backgroundColor: selectedColor.get())
                    miniSheetManager.showCustomMiniSheet(titleText: "Select Unit", backgroundColor: selectedColor.get(), height: 400*Layout.multiplierHeight) { EmptyView() }
                }
            }
        }
        .frame(height: 200*Layout.multiplierHeight)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
