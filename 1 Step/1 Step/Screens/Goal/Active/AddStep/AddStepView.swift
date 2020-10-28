//
//  AddStepView.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct AddStepView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @ObservedObject var viewModel: AddStepModel
    
    
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
        .onChange(of: goalModel.selectedGoal.step.addArray) { _ in viewModel.setupAddStepView(true, goalModel.selectedGoal) }
        .onChange(of: goalModel.noDrag) { viewModel.setupAddStepView($0, goalModel.selectedGoal) }
    }
}




