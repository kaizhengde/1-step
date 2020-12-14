//
//  GoalSelectMountainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalSelectMountainView: View {
    
    @ObservedObject var viewModel: GoalSelectMountainModel
    @GestureState private var dragOffset: CGFloat = .zero
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MountainImage.allCases, id: \.self) { mountain in
                GoalSelectMountainItem(viewModel: viewModel, mountain: mountain)
                    .highPriorityGesture(
                        DragGesture()
                            .updating($dragOffset) { viewModel.updating($0, &$1, $2) }
                            .onEnded { viewModel.onEnded($0) }
                    )
                    .onChange(of: dragOffset) { viewModel.dragOffset = $0 }
            }
            .frame(width: Layout.screenWidth, height: MountainLayout.height)
        }
        .frame(width: Layout.screenWidth, alignment: .leading)
        .onPreferenceChange(GoalSelectMountainModel.MountainPK.self) { viewModel.updatePreferences($0) }
        .coordinateSpace(name: CoordinateSpace.selectMountain.hashValue)
        .oneSAnimation()
        .onAppear {
            viewModel.initTransition()
            viewModel.considerFirstSelectMountain()
        }
        .onChange(of: viewModel.currentMountain) { _ in
            viewModel.considerFirstSelectColor()
        }
    }
}
