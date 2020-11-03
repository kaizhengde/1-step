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
                                
                                if goalModel.showJourneyView {
                                    JourneyView()
                                        .opacity(goalModel.journeyViewDragOpacity)
                                        .opacity(goalModel.showJourneyView ? 1.0 : 0.0)
                                        .offset(y: -250)
                                }
                            }
                        }
                        .offset(x: goalModel.goalContentDragOffset)
                    }
                    .onReceive(goalModel.setScrollPosition) { position in
                        withAnimation { scrollProxy.scrollTo(position, anchor: .center) }
                    }
                }
                .background(GoalModel.ScrollVS())
                .onPreferenceChange(GoalModel.ScrollPK.self) { goalModel.updatePreferences($0) }                
            }
            .opacity(goalModel.viewDragOpacity)
            .coordinateSpace(name: CoordinateSpace.goalScroll)
        }
        .offset(x: goalModel.goalDragOffset)
    }
}



