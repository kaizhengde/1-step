//
//  GoalSelectMountainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalSelectMountainView: View {
    
    @StateObject private var viewModel = GoalSelectMountainModel()
    
    
    var body: some View {
        ZStack {
            //Mountains
            HStack(spacing: 0) {
                ForEach(MountainImage.allCases, id: \.self) { mountain in
                    GoalSelectMountainItem(viewModel: viewModel, mountain: mountain)
                        .highPriorityGesture(viewModel.dragMountains)
                }
                .frame(width: ScreenSize.width, height: MountainLayout.height)
            }
            .onPreferenceChange(GoalSelectMountainModel.MountainPK.self) { p in viewModel.updatePreferences(p) }
            
            //Select Button
            
        }
        .frame(width: ScreenSize.width, alignment: .leading)
        .coordinateSpace(name: CoordinateSpace.selectMountain.hashValue)
        .oneSAnimation(delay: viewModel.transitionDelay())
        .onAppear { viewModel.initTransition() }
    }
}
