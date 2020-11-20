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

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0..<viewModel.examples.count) { i in
                OneSDropDown(.shortBig, title: viewModel.examples[i].example) {
                    GoalExampleMapView(data: viewModel.examples[i].data, selectedColor: selectedColor, big: false)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
