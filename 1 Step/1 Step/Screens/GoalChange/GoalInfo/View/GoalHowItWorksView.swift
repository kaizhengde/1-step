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
    let data = GoalInfoModel.HowItWorksData.self
    
    
    var body: some View {
        VStack(spacing: 26) {            
            OneSTextPassage(passageData: data.textPassageOne)
            GoalExampleMapView(data: data.exampleOne, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: data.textPassageTwo)
            GoalExampleMapView(data: data.exampleTwo, selectedColor: selectedColor, big: true)
            OneSTextPassage(passageData: data.textPassageThree)
        }
        .padding(.bottom, 20)
        .onAppear { FirebaseAnalyticsEvent.GoalInfo.openHowItWorks() }
    }
}
