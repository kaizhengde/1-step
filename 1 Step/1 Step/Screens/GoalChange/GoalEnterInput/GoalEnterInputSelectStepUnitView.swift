//
//  GoalEnterInputSelectStepUnitView.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

struct GoalEnterInputSelectStepUnitView: View {
    
    @ObservedObject var viewModel: GoalEnterInputModel
    @Binding var selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            //Header
            HStack {
                OneSSecondaryHeaderText(text: Localized.selectUnit, color: .backgroundToGray)
                Spacer()
                OneSSmallBorderButton(symbol: SFSymbol.`continue`, color: .backgroundToGray, withScale: false) { MiniSheetManager.shared.dismiss() }
            }
            .padding(.bottom, 20)
            
            //StepCategory
            HStack {
                StepCategoryButton(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .duration)
                Spacer()
                StepCategoryButton(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .distance)
                Spacer()
                StepCategoryButton(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .reps)
            }
            
            //StepUnit
            HStack {
                switch viewModel.selectedData.stepCategory {
                case .duration:
                    StepUnitButtons(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .duration)
                case .distance:
                    StepUnitButtons(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .distance)
                case .reps:
                    StepUnitButtons(viewModel: viewModel, selectedColor: $selectedColor, stepCategory: .reps)
                default:
                    EmptyView()
                }
            }
        }
    }
    
    
    private struct StepCategoryButton: View {
        
        @ObservedObject var viewModel: GoalEnterInputModel
        @Binding var selectedColor: UserColor
        let stepCategory: StepCategory
        
        
        var body: some View {
            OneSFillButton(
                text:           stepCategory.description,
                textFont:       .subtitle,
                textColor:      viewModel.stepCategoryButtonTextColor(stepCategory),
                buttonColor:    viewModel.stepCategoryButtonColor(stepCategory, selectedColor),
                height:         55,
                withScale:      false
            ) {
                viewModel.selectedData.stepCategory = stepCategory
            }
        }
    }
    
    
    private struct StepUnitButtons: View {
        
        @ObservedObject var viewModel: GoalEnterInputModel
        
        @Binding var selectedColor: UserColor
        let stepCategory: StepCategory
        
        var stepUnits: [StepUnit] { StepUnit.unitsOfCategory(stepCategory) }
        var stepUnitsWithOutCustom: [StepUnit] { stepUnits.filter { !$0.isCustom } }
        
        
        var body: some View {
            VStack(spacing: 10) {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 10) {
                    ForEach(0..<stepUnitsWithOutCustom.count) { i in
                        StepUnitButton(viewModel: viewModel, selectedColor: $selectedColor, stepUnit: stepUnitsWithOutCustom[i])
                    }
                }
                if stepCategory == .reps {
                    StepUnitButton(viewModel: viewModel, selectedColor: $selectedColor, stepUnit: .custom)
                }
            }
        }
        
        
        private struct StepUnitButton: View {
            
            @StateObject private var popupManager = PopupManager.shared
            @ObservedObject var viewModel: GoalEnterInputModel
            
            @Binding var selectedColor: UserColor
            let stepUnit: StepUnit
            
            
            var body: some View {
                OneSFillButton(
                    text:           stepUnit.description,
                    textFont:       .custom(.semiBold, 14),
                    textColor:      viewModel.stepUnitButtonTextColor(stepUnit),
                    buttonColor:    viewModel.stepUnitButtonColor(stepUnit, selectedColor),
                    height:         40,
                    withScale:      false
                ) {
                    if stepUnit.isCustom {
                        popupManager.showPopup(.goalCustomUnit, backgroundColor: selectedColor.standard) {
                            OneSTextFieldPopupView(
                                titleText: Localized.custom,
                                bodyText: Localized.GoalChange.enterCustomUnit,
                                initialInput: viewModel.selectedData.customUnit,
                                placeholder: Localized.Step.unit_custom,
                                placeholderColor: selectedColor.dark,
                                inputLimit: Step.customUnitDigitsLimit,
                                firstResponder: true
                            )
                        }
                    }
                    viewModel.selectedData.stepUnit = stepUnit
                }
                .onReceive(popupManager.confirmBtnDismissed) { confirmData in
                    if confirmData.key == .goalCustomUnit {
                        DispatchQueue.main.async {
                            viewModel.selectedData.customUnit = confirmData.input.trimmingCharacters(in: .whitespaces)
                        }
                    }
                }
            }
        }
    }
}
