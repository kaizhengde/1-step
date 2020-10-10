//
//  GoalSelectMountainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalSelectMountainView: View {
    
    @ObservedObject var viewModel: GoalSelectMountainModel
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MountainImage.allCases, id: \.self) { mountain in
                GoalSelectMountainItem(viewModel: viewModel, mountain: mountain)
                    .highPriorityGesture(viewModel.dragMountains)
            }
            .frame(width: Layout.screenWidth, height: MountainLayout.height)
        }
        .frame(width: Layout.screenWidth, alignment: .leading)
        .onPreferenceChange(GoalSelectMountainModel.MountainPK.self) { p in viewModel.updatePreferences(p) }
        .coordinateSpace(name: CoordinateSpace.selectMountain.hashValue)
        .oneSAnimation()
        .onAppear { viewModel.initTransition() }
    }
}
