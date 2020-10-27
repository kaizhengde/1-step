//
//  AddView.swift
//  1 Step
//
//  Created by Kai Zheng on 26.10.20.
//

import SwiftUI

struct AddView: View {
    
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
        .offset(x: viewModel.dragState == .show ? 0 : 220/*280*/)
        .alignmentGuide(.addStepAlignment) { d in d[.top] }
        .oneSAnimation(duration: 0.3)
    }
    
    
    private struct SelectView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: AddStepModel
        
        
        var body: some View {
            VStack {
                if viewModel.dragState == .show {
                    OneSPicker(selected: $viewModel.selectedStep, data: Array(0...10).map { "\($0)" }, unit: goalModel.selectedGoal.step.unit, selectedColor: goalModel.selectedGoal.color.get())
                }
                
                //OneSDoublePicker(data: (Array(0...24).map { "\($0)" }, Array(0...60).map { "\($0)" }), unit: ("h", "min"), selectedColor: goalModel.selectedGoal.color.get())
            }
            .frame(width: 180/*240*/, height: 175)
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
                    .foregroundColor(.backgroundToGray)
            }
            .frame(width: 90, height: 90)
            .background(goalModel.selectedGoal.color.get(.dark))
            .offset(y: viewModel.dragState == .show ? 0 : -100)
            .onTapGesture { viewModel.dragState = .hidden }
        }
    }
}
