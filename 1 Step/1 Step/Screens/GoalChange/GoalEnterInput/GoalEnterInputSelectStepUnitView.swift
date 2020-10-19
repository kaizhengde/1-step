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
            //StepCategory
            HStack {
                StepCategoryButton(viewModel: viewModel, stepCategory: .duration)
                Spacer()
                StepCategoryButton(viewModel: viewModel, stepCategory: .distance)
                Spacer()
                StepCategoryButton(viewModel: viewModel, stepCategory: .reps)
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
        let stepCategory: StepCategory
        
        
        var body: some View {
            OneSFillButton(
                text:           stepCategory.description,
                textFont:       .subtitle,
                textColor:      viewModel.stepCategoryButtonTextColor(stepCategory),
                buttonColor:    viewModel.stepCategoryButtonColor(stepCategory),
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
        var stepUnitsWithOutCustom: [StepUnit] { stepUnits.filter { $0 != .custom } }
        
        
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
                    textFont:       .custom(weight: Raleway.semiBold, size: 14),
                    textColor:      viewModel.stepUnitButtonTextColor(stepUnit),
                    buttonColor:    viewModel.stepUnitButtonColor(stepUnit),
                    height:         40,
                    withScale:      false
                ) {
                    if stepUnit == .custom {
                        popupManager.showTextFieldPopup(titleText: "Custom", bodyText: "Enter your unit.", input: viewModel.selectedData.stepCustomUnit, placerholder: "unit", inputColor: .backgroundToGray, placerholderColor: .opacityBackgroundDarker, textLimit: Step.customUnitDigitsLimit, lowercased: true, backgroundColor: selectedColor.get())
                    }
                    viewModel.selectedData.stepUnit = stepUnit
                }
                .onReceive(popupManager.textFieldSave, perform: {
                    DispatchQueue.main.async { viewModel.selectedData.stepCustomUnit = popupManager.input }
                })
            }
        }
    }
}
