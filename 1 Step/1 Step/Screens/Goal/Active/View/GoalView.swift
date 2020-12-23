//
//  GoalView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalView: View {
    
    @StateObject private var goalModel = GoalModel.shared

    
    var body: some View {
        Group {
            Color.backgroundToGray
                .edgesIgnoringSafeArea(.all)
                .oneSShadow(opacity: 0.2, y: 0, blur: 13)
            
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollProxy in
                    ZStack(alignment: .top) {
                        Color.clear.frame(height: 0).id(GoalModel.ScrollPosition.top)
                        
                        GoalHeaderView()
                        
                        Group {
                            goalModel.backgroundColor.offset(y: Layout.screenHeight + 20)
                            
                            VStack {
                                GoalSummaryView()
                                
                                if goalModel.showJourneyView && goalModel.dragState == .none {
                                    JourneyView(state: .active)
                                        .opacity(goalModel.journeyViewDragOpacity)
                                        .padding(.top, -250)
                                        .padding(.bottom, 250*Layout.multiplierHeight)
                                        .onAppear { goalModel.journeyViewDisappeared = false }
                                        .onDisappear { goalModel.journeyViewDisappeared = true }
                                }
                            }
                        }
                        .offset(x: goalModel.goalContentDragOffset)
                    }
                    .onReceive(goalModel.setScrollPosition) { position in
                        withAnimation { scrollProxy.scrollTo(position, anchor: .bottom) }
                    }
                }
                .background(GoalModel.ScrollVS())
                .onPreferenceChange(GoalModel.ScrollPK.self) { goalModel.updatePreferences($0) }                
            }
            .disabled(!goalModel.transition.isFullAppeared)
            .opacity(goalModel.viewDragOpacity)
            .coordinateSpace(name: CoordinateSpace.goalScroll)
        }
        .offset(x: goalModel.goalDragOffset)
    }
}



