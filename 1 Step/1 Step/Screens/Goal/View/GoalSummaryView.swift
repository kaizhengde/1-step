//
//  GoalSummaryView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalSummaryView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            MountainView()
            DetailsView()
        }
    }
    
    
    private struct DetailsView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        
        var body: some View {
            Group {
                TopView()
                BottomView()
            }
            .opacity(goalModel.transition.isFullAppeared ? 1.0 : 0.0)
        }
        
        
        private struct TopView: View {
            
            @EnvironmentObject var goalModel: GoalModel
            
            
            var body: some View {
                VStack(spacing: -5) {
                    OneSText(text: goalModel.selectedGoal.name, font: .custom(weight: Raleway.light, size: 28), color: goalModel.topTextColor)
                    
                    HStack(spacing: 3) {
                        OneSText(text: "\(goalModel.selectedGoal.stepsNeeded)", font: .custom(weight: Raleway.bold, size: 45), color: goalModel.topTextColor)
                        
                        OneSText(text: goalModel.stepUnitText, font: .custom(weight: Raleway.bold, size: 36), color: goalModel.topTextColor)
                    }
                }
                .frame(height: 80)
                .padding(.horizontal, Layout.secondLayerPadding)
                .padding(.top, MountainLayout.offsetY - 85)
            }
        }
        
        
        private struct BottomView: View {
            
            @EnvironmentObject var goalModel: GoalModel
            
            
            var body: some View {
                VStack(spacing: 0) {
                    OneSText(text: "\(goalModel.selectedGoal.currentPercent)%", font: .custom(weight: Raleway.extraBold, size: 60), color: .backgroundToGray)
                    
                    SFSymbol.downArrow
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(.backgroundToGray)
                }
                .frame(height: 80)
                .padding(.horizontal, Layout.secondLayerPadding)
                .padding(.top, Layout.screenHeight - 140 - SafeAreaSize.bottom)
            }
        }
    }
    
    
    private struct MountainView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        
        var body: some View {
            goalModel.selectedGoal.mountain.get()
                .renderingMode(.template)
                .resizable()
                .frame(width: Layout.screenWidth, height: MountainLayout.height)
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .padding(.top, goalModel.mountainTransitionOffset)
                .animation(goalModel.mountainAnimation)
                .foregroundColor(.white)
                .colorMultiply(goalModel.backgroundColor)
        }
    }
}

