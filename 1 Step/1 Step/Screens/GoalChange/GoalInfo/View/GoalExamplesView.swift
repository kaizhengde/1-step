//
//  GoalExamplesView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

struct GoalExamplesView: View {
    
    @ObservedObject var viewModel: GoalInfoModel
    
    let selectedColor: UserColor
    let examples = GoalInfoModel.ExamplesData.examples

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(0..<examples.count) { i in
                OneSDropDown(.shortBig, title: examples[i].example) {
                    GoalExampleMapView(data: examples[i].data, selectedColor: selectedColor, big: false)
                }
                .simultaneousGesture(
                    TapGesture().onEnded { FirebaseAnalyticsEvent.GoalInfo.tapOnParticularExample() }
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear { FirebaseAnalyticsEvent.GoalInfo.openExamples() }
    }
}
