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
        ZStack {
            ZStack(alignment: .top) {
                //Mountain Text
                GoalSelectMountainText(viewModel: viewModel, mountain: mountain)
                
                //Mountain
                GoalSelectMountainImage(viewModel: viewModel, mountain: mountain)
            }
            .padding(.top, MountainLayout.offsetY*1.5)
            
            //Select Button
            GoalSelectMountainButton(viewModel: viewModel, mountain: mountain)
        }
        .scaleEffect(viewModel.mountainItemScale(mountain))
        .offset(x: viewModel.mountainItemOffsetX())
    }
    
    
    private struct GoalSelectMountainText: View {
        
        @ObservedObject var viewModel: GoalSelectMountainModel
        let mountain: MountainImage
        
        
        var body: some View {
            VStack(spacing: -5) {
                OneSTextView(text: mountain.getName().top, font: .custom(weight: Raleway.light, size: 28), color: .grayToBackground)
                
                OneSTextView(text: mountain.getName().bottom, font: .custom(weight: Raleway.bold, size: 40), color: .grayToBackground)
            }
            .frame(width: Layout.firstLayerWidth, height: 80)
            .opacity(viewModel.textAndButtonOpacity(mountain))
            .padding(.top, -85)
        }
    }
    
    
    private struct GoalSelectMountainImage: View {
        
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
                .oneSMountainAnimation(delay: viewModel.mountainTransitionDelay())
                .background(GoalSelectMountainModel.MountainVS(mountainID: mountain.rawValue))
                .onTapGesture { viewModel.newMountainColor() }
        }
    }
    
    
    private struct GoalSelectMountainButton: View {
        
        @ObservedObject var viewModel: GoalSelectMountainModel
        let mountain: MountainImage
        
        
        var body: some View {
            VStack {
                Spacer()
                OneSBorderButton(text: viewModel.selectButtonText(mountain), color: viewModel.selectButtonColor(mountain)) { viewModel.selectMountainAndDismiss() }
            }
            .padding(.bottom, 200)
            .opacity(viewModel.textAndButtonOpacity(mountain))
        }
    }
}
