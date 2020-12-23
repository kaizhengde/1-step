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
                OneSText(text: mountain.name.top, font: .custom(.light, 28*Layout.multiplierWidth), color: .grayToBackground)
                
                OneSText(text: mountain.name.bottom, font: .custom(.bold, 46*Layout.multiplierWidth), color: .grayToBackground)
            }
            .frame(width: Layout.firstLayerWidth, height: 80)
            .opacity(viewModel.textAndButtonOpacity(mountain))
            .padding(.top, MountainLayout.offsetYTextNoScrollView)
        }
    }
    
    
    private struct GoalSelectMountainImage: View {
        
        @ObservedObject var viewModel: GoalSelectMountainModel
        let mountain: MountainImage
        
        
        var body: some View {
            mountain.image
                .renderingMode(.template)
                .resizable()
                .frame(width: Layout.screenWidth, height: MountainLayout.height)
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(.white)
                .colorMultiply(viewModel.mountainColor(mountain))
                .offset(y: viewModel.mountainTransistionOffset())
                .oneSMountainAnimation()
                .background(GoalSelectMountainModel.MountainVS(mountainID: mountain.rawValue))
                .onTapGesture { viewModel.selectMountainColor() }
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
            .padding(.bottom, 40*Layout.multiplierHeight)
            .opacity(viewModel.textAndButtonOpacity(mountain))
        }
    }
}
