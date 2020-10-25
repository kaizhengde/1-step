//
//  AddStepView.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct AddStepView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel = AddStepModel()
    
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack(alignment: .init(horizontal: .trailing, vertical: .addStepAlignment)) {
                ZStack {
                    HiddenView(viewModel: viewModel)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                
                AddView(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: -60 * Layout.multiplierHeight)
        .oneSAnimation()
    }
    
    
    private struct HiddenView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
        @ObservedObject var viewModel: AddStepModel
        
        
        var body: some View {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 140)
                .foregroundColor(viewModel.hiddenForegroundColor(goalModel.selectedGoal.color.get(.light), goalModel.selectedGoal.color.get(.dark) ))
                .oneSShadow(opacity: 0.12, x: 0, y: 2, blur: 8)
                .offset(x: viewModel.animate ? -5 : 0)
                .scaleEffect(y: viewModel.animate ? 1.05 : 1.0)
                .offset(x: viewModel.dragState == .show ? -50 : viewModel.dragOffset)
                .scaleEffect(y: viewModel.dragHiddenScaleEffect)
                .overlay(
                    Group {
                        if goalModel.showAddStepDragArea {
                            Color.hidden.frame(width: 150, height: 300)
                        }
                    }
                )
                .padding(8)
                .highPriorityGesture(viewModel.dragGesture)
                .offset(x: goalModel.addStepViewOffset)
                .alignmentGuide(.addStepAlignment) { d in d[.top] }
        }
    }
    
    
    private struct AddView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @ObservedObject var viewModel: AddStepModel
        
        
        var body: some View {
            VStack(alignment: .trailing, spacing: 5) {
                Group {
                    VStack {
                        OneSPicker(data: Array(1...10).map { "\($0)" }, unit: goalModel.selectedGoal.step.unit, selectedColor: goalModel.selectedGoal.color.get())
                    }
                    .frame(width: 180, height: 175)
                    .background(goalModel.selectedGoal.color.get(.dark))
    
                    VStack {
                        SFSymbol.plus
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.backgroundToGray)
                    }
                    .frame(width: 90, height: 90)
                    .background(goalModel.selectedGoal.color.get(.light))
                    .offset(y: viewModel.dragState == .show ? 0 : -100)
                    .onTapGesture { viewModel.dragState = .hidden }
                }
                .cornerRadius(12)
                .oneSShadow(opacity: 0.12, x: 0, y: 2, blur: 8)
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .offset(x: viewModel.dragState == .show ? 0 : 220)
            .oneSAnimation(duration: 0.3)
            .alignmentGuide(.addStepAlignment) { d in d[.top] }
        }
    }
}




