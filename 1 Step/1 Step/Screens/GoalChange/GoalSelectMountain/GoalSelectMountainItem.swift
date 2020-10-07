//
//  GoalSelectMountainItem.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalSelectMountainItem: View {
    
    @ObservedObject var viewModel: GoalSelectMountainModel
    
    let mountain: MountainImage
    
    
    var body: some View {
        mountain.get()
            .renderingMode(.template)
            .resizable()
            .frame(width: ScreenSize.width, height: MountainLayout.height)
            .aspectRatio(contentMode: .fit)
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(.white)
            .colorMultiply(viewModel.mountainColor(mountain))
            .offset(y: viewModel.transistionOffset())
            .oneSMountainAnimation()
            .background(GoalSelectMountainModel.MountainVS(mountainID: mountain.rawValue))
            .padding(.top, MountainLayout.offsetY*1.5)
            .scaleEffect(viewModel.mountainItemScale(mountain))
            .offset(x: viewModel.mountainItemOffsetX())
    }
}
