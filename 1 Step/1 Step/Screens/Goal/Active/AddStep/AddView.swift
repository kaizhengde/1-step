//
//  AddView.swift
//  1 Step
//
//  Created by Kai Zheng on 26.10.20.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @ObservedObject var viewModel: AddStepModel
    
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Group {
                SelectView(viewModel: viewModel)
                AddButton(viewModel: viewModel)
            }
            .cornerRadius(12)
            .oneSShadow(opacity: 0.12, x: 0, y: 2, blur: 8)
        }
        .padding(.horizontal, Layout.firstLayerPadding)
        .offset(x: viewModel.dragState == .show ? 0 : goalModel.selectedGoal.step.addArrayDual.isEmpty || goalModel.selectedGoal.step.addArray.isEmpty ? 220 : 280)
        .alignmentGuide(.addStepAlignment) { d in d[.top] }
        .oneSAnimation(duration: 0.3)
    }
    
    
    private struct SelectView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: AddStepModel
        
        var step: Step { goalModel.selectedGoal.step }
        var singlePicker: Bool { step.addArrayDual.isEmpty || step.addArray.isEmpty }
        
        
        var body: some View {
            VStack {
                if viewModel.dragState == .show {
                    if singlePicker {
                        OneSPicker(
                            selected: $viewModel.selectedStep.unit,
                            data: viewModel.stepsAddArray.unit.isEmpty ? viewModel.stepsAddArray.dual : viewModel.stepsAddArray.unit,
                            unit: step.unit == .custom ? goalModel.selectedGoal.step.customUnit : viewModel.stepsAddArray.unit.isEmpty ? step.unit.dualUnit!.description : step.unit.description,
                            selectedColor: goalModel.selectedGoal.color.get()
                        )

                    } else {
                        OneSDualPicker(
                            selectedLeft: $viewModel.selectedStep.unit,
                            selectedRight: $viewModel.selectedStep.dual,
                            data: (viewModel.stepsAddArray.unit, viewModel.stepsAddArray.dual),
                            unit: (step.unit.description, step.unit.dualUnit!.description),
                            selectedColor: goalModel.selectedGoal.color.get()
                        )
                    }
                }
            }
            .frame(width: singlePicker ? 180 : 240, height: 175)
            .background(goalModel.selectedGoal.color.get(.light))
        }
    }
    
    
    private struct AddButton: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: AddStepModel
        
        
        var body: some View {
            VStack {
                SFSymbol.plus
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.backgroundStatic)
            }
            .frame(width: 90, height: 90)
            .background(goalModel.selectedGoal.color.get(.dark))
            .offset(y: viewModel.dragState == .show ? 0 : -100)
            .onTapGesture { viewModel.dragState = .hidden }
        }
    }
}
