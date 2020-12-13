//
//  GoalHowItWorksView.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

struct GoalHowItWorksView: View {
    
    @ObservedObject var viewModel: GoalInfoModel
    
    let selectedColor: UserColor
    
    
    var body: some View {
        VStack(spacing: 26) {            
            OneSTextPassage(passageData: viewModel.howItWorksTextPassageOneData)
            GoalExampleMapView(data: viewModel.howItWorksExampleOneData, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: viewModel.howItWorksTextPassageTwoData)
            GoalExampleMapView(data: viewModel.howItWorksExampleTwoData, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: viewModel.howItWorksTextPassageThreeData)
            GoalExampleMapView(data: viewModel.howItWorksExampleThreeData, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: viewModel.howItWorksTextPassageFourData)
            GoalExampleMapView(data: viewModel.howItWorksExampleFourData, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: viewModel.howItWorksTextPassageFiveData)
        }
        .padding(.bottom, 20)
    }
}
