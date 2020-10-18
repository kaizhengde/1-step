//
//  GoalEditScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct GoalEditScreen: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel = GoalEditModel()
    @StateObject private var goalSelectMountainModel = GoalSelectMountainModel()
    @StateObject private var goalEnterInputModel = GoalEnterInputModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Group {
                        OneSHeaderView("Edit", trailingButton: (.close, .grayToBackground, { goalModel.onEdit = false }), secondaryButtonOuter: (.save, {}), secondaryButtonInner: (.delete, {}))
                        
                        GoalEnterInputView(viewModel: goalEnterInputModel, selectedColor: goalModel.selectedGoal.color)
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                }
                .padding(.top, 12)
            }
        }
        .onAppear {
            goalSelectMountainModel.delegate = viewModel
            goalEnterInputModel.delegate = viewModel
        }
    }
}
