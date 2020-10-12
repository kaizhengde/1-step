//
//  GoalsScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsScreen: View {
    
    @EnvironmentObject var goalsModel: GoalsModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GoalsHeaderView()
                
                if goalsModel.currentTab == .active {
                    GoalsActiveView()
                } else {
                    GoalsReachedView()
                }
            }
            .frame(width: Layout.firstLayerWidth)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, goalsModel.scrollViewBottomPadding)
        }
    }
}
