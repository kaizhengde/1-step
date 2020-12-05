//
//  GoalReachedSummaryView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

struct GoalReachedSummaryView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            MountainView()
            DetailsView()
        }
    }
    
    
    private struct DetailsView: View {
        
        @StateObject private var goalReachedModel = GoalReachedModel.shared
        
        
        var body: some View {
            Group {
                TopView()
                BottomView()
            }
            .opacity(goalReachedModel.transition.isFullAppeared ? 1.0 : 0.0)
        }
        
        
        private struct TopView: View {
            
            @StateObject private var goalReachedModel = GoalReachedModel.shared
            
            
            var body: some View {
                VStack(spacing: -5) {
                    OneSText(text: goalReachedModel.selectedGoal.name, font: .custom(.light, 32*Layout.multiplierHeight), color: .grayToBackground)
                    
                    HStack(spacing: 3) {
                        OneSText(text: "\(goalReachedModel.selectedGoal.neededStepUnits)", font: .custom(.bold, 52*Layout.multiplierWidth), color: .grayToBackground)
                        
                        OneSText(text: goalReachedModel.selectedGoal.step.unitDescription, font: .custom(.bold, 40*Layout.multiplierWidth), color: .grayToBackground)
                    }
                }
                .frame(height: 80)
                .padding(.horizontal, Layout.secondLayerPadding)
                .padding(.top, MountainLayout.offsetYText)
                .offset(y: MountainLayout.offsetYFlag)
                .opacity(goalReachedModel.transition.isFullAppeared ? 1.0 : 0.0)
            }
        }
        
        
        private struct BottomView: View {
            
            var body: some View {
                OneSText(text: "100%", font: .custom(.extraBold, 60), color: .backgroundToGray)
                    .frame(height: 120)
                    .padding(.horizontal, Layout.secondLayerPadding)
                    .padding(.top, Layout.screenHeight - 240*Layout.multiplierHeight - SafeAreaSize.bottom)
            }
        }
    }
    
    
    private struct MountainView: View {
        
        @StateObject private var goalReachedModel = GoalReachedModel.shared
        
        
        var body: some View {
            ZStack(alignment: .init(horizontal: .flagMountainAlignment, vertical: .top)) {
                goalReachedModel.selectedGoal.mountain.image
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: Layout.screenWidth, height: MountainLayout.height)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.white)
                    .colorMultiply(goalReachedModel.selectedGoal.color.standard)
                    
                MountainImage.Flag.whole
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .colorMultiply(goalReachedModel.selectedGoal.color.standard)
                    .alignmentGuide(.flagMountainAlignment) { $0[.leading] }
                    .offset(y: -40)
            }
            .padding(.top, goalReachedModel.mountainTransitionOffset)
            .animation(goalReachedModel.mountainAnimation)
        }
    }
}
