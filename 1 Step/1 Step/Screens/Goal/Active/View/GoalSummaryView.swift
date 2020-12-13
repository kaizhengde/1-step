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
        
        @StateObject private var goalModel = GoalModel.shared
        
        
        var body: some View {
            Group {
                TopView()
                BottomView()
            }
            .opacity(goalModel.transition.isFullAppeared ? 1.0 : 0.0)
        }
        
        
        private struct TopView: View {
            
            @StateObject private var goalModel = GoalModel.shared
            
            
            var body: some View {
                VStack(spacing: -5) {
                    OneSText(text: goalModel.selectedGoal.name, font: .custom(.light, 32*Layout.multiplierHeight), color: goalModel.topTextColor)
                    
                    HStack(spacing: 3) {
                        OneSText(text: "\(goalModel.selectedGoal.neededStepUnits)", font: .custom(.bold, 52*Layout.multiplierWidth), color: goalModel.topTextColor)
                        
                        OneSText(text: goalModel.selectedGoal.step.unitDescription, font: .custom(.bold, 40*Layout.multiplierWidth), color: goalModel.topTextColor)
                    }
                    .minimumScaleFactor(0.9)
                }
                .frame(height: 80)
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.top, MountainLayout.offsetYText)
                .offset(y: goalModel.showFlag ? MountainLayout.offsetYFlag : 0)
            }
        }
        
        
        private struct BottomView: View {
            
            @StateObject private var goalModel = GoalModel.shared
            
            
            var body: some View {
                VStack(spacing: 16) {
                    OneSText(text: goalModel.selectedGoal.currentState == .active ?  "\(goalModel.selectedGoal.currentPercent)%" : "100%", font: .custom(.extraBold, 60), color: .backgroundToGray)
                        .opacity(goalModel.showJourneyView ? 0.0 : 1.0)
                    
                    if goalModel.showDownArrow {
                        DownArrowView()
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture { goalModel.downArrowTapped() }
                .frame(height: 120)
                .padding(.horizontal, Layout.secondLayerPadding)
                .padding(.top, Layout.screenHeight - 200*Layout.multiplierHeight - SafeAreaSize.bottom)
            }
            
            
            private struct DownArrowView: View {
                
                @StateObject private var goalModel = GoalModel.shared
                @StateObject private var infinteAnimationManager = InfiniteAnimationManager.shared
                                
                private var animationOnForwardActive: Bool { infinteAnimationManager.slow.isOnForward && !goalModel.showJourneyView }
                
                
                var body: some View {
                    DownArrow(width: 80, offset: goalModel.showJourneyView ? -20 : 20)
                        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .frame(width: 80)
                        .foregroundColor(.backgroundToGray)
                        .offset(y: goalModel.showJourneyView ? -180 : 0)
                        .oneSAnimation()
                        .scaleEffect(x: animationOnForwardActive ? 1.0 : 0.6, y: animationOnForwardActive ? 1.0 : 0.7)
                        .offset(y: animationOnForwardActive ? 0 : 24)
                        .animation(goalModel.showJourneyView ? .oneSAnimation() : InfiniteAnimationManager.slowAnimation)
                }
                
                
                private struct DownArrow: Shape {
                    
                    let width: CGFloat
                    var offset: CGFloat
                    
                    var animatableData: CGFloat {
                        get { offset }
                        set { offset = newValue }
                    }
                    
                    
                    func path(in rect: CGRect) -> Path {
                        var path = Path()
                        
                        path.move(to: .zero)
                        path.addLine(to: CGPoint(x: width/2, y: offset))
                        path.move(to: CGPoint(x: width/2, y: offset))
                        path.addLine(to: CGPoint(x: width, y: 0))
                        
                        return path
                    }
                }
            }
        }
    }
    
    
    private struct MountainView: View {
        
        @StateObject private var goalModel = GoalModel.shared
        
        
        var body: some View {
            ZStack(alignment: .init(horizontal: .flagMountainAlignment, vertical: .top)) {
                goalModel.selectedGoal.mountain.image
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: Layout.screenWidth, height: MountainLayout.height)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.white)
                    .colorMultiply(goalModel.backgroundColor)
                    
                FlagView()
            }
            .padding(.top, goalModel.mountainTransitionOffset)
            .animation(goalModel.mountainAnimation)
        }
    }
    
    
    private struct FlagView: View {
        
        @StateObject private var goalModel = GoalModel.shared
        
        
        var body: some View {
            ZStack {
                MountainImage.Flag.top
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .colorMultiply(goalModel.backgroundColor)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.backgroundToGray)
                            .scaleEffect(x: goalModel.showFlag ? 0 : 1, y: 1, anchor: .trailing)
                            .animation(goalModel.mountainAnimation.delay(goalModel.showFlag ? 0.6 : 0.0))
                            .offset(y: -10)
                    )
                
                MountainImage.Flag.line
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .colorMultiply(goalModel.backgroundColor)
                    .scaleEffect(x: 1, y: goalModel.showFlag ? 1 : 0, anchor: .bottom)
                    .oneSAnimation()
            }
            .alignmentGuide(.flagMountainAlignment) { $0[.leading] }
            .offset(y: -40)
        }
    }
}

