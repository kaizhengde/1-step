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
            .colorMultiply(mountainColor())
            .offset(y: transistionOffset())
            .background(GoalSelectMountainModel.MountainVS(mountainID: mountain.rawValue))
    }
    
    
    func transistionOffset() -> CGFloat {
        return ScreenSize.height/1.3
    }
    
    
    func mountainColor() -> Color {
        return CGFloat(mountain.rawValue) == viewModel.currentMountain ? MountainColor.mountain0 : .darkBackgroundToBlack
    }
}
