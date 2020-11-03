//
//  AddView.swift
//  1 Step
//
//  Created by Kai Zheng on 26.10.20.
//

import SwiftUI

struct AddView: View {
    
    @StateObject private var goalModel = GoalModel.shared
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
        .offset(x: viewModel.dragState == .show ? 0 : goalModel.selectedGoal.step.oneAddArrayEmpty ? 220 : 280)
        .alignmentGuide(.addStepAlignment) { d in d[.top] }
        .oneSAnimation(duration: 0.3)
    }
    
    
    private struct SelectView: View {
        
        @StateObject private var goalModel = GoalModel.shared
        @ObservedObject var viewModel: AddStepModel
        
        var step: Step { goalModel.selectedGoal.step }
        
        
        var body: some View {
            VStack {
                if viewModel.dragState == .show {
                    if step.oneAddArrayEmpty {
                        OneSPicker(
                            data: step.addArray.isEmpty ? $goalModel.selectedGoal.step.addArrayDual : $goalModel.selectedGoal.step.addArray,
                            selected: step.addArray.isEmpty ? $viewModel.selectedStep.dual : $viewModel.selectedStep.unit,
                            unit: step.unit == .custom ? goalModel.selectedGoal.step.customUnit : (step.addArray.isEmpty ? step.unit.dualUnit!.description : step.unit.description),
                            selectedColor: goalModel.selectedGoal.color.get()
                        )

                    } else {
                        OneSDualPicker(
                            dataLeft: $goalModel.selectedGoal.step.addArray,
                            dataRight: $goalModel.selectedGoal.step.addArrayDual,
                            selectedLeft: $viewModel.selectedStep.unit,
                            selectedRight: $viewModel.selectedStep.dual,
                            unit: (step.unit.description, step.unit.dualUnit!.description),
                            selectedColor: goalModel.selectedGoal.color.get()
                        )
                    }
                }
            }
            .frame(width: step.oneAddArrayEmpty ? 180 : 240, height: 175)
            .background(goalModel.selectedGoal.color.get(.light))
        }
    }
    
    
    private struct AddButton: View {
        
        @StateObject private var goalModel = GoalModel.shared
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
            .onTapGesture {
                viewModel.tryAddStepsAndHide()
                goalModel.objectWillChange.send()
                goalModel.didAddSteps.send()
                goalModel.setScrollPosition.send(.current)
            }
        }
    }
}
