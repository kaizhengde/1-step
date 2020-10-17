//
//  GoalHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalHeaderView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    
    
    var body: some View {
        VStack {
            OneSHeaderView(leadingButton: (.custom(AnyView(MenuButton())), goalModel.headerButtonColor, {}), trailingButton: (.settings, goalModel.headerButtonColor, {}))
            Spacer()
        }
        .padding(.horizontal, Layout.firstLayerPadding)
        .opacity(!goalModel.transition.isFullHidden ? 1.0 : 0.0)
        .offset(y: !goalModel.transition.isFullHidden ? 0 : -30)
        .oneSAnimation()
    }
    
    
    private struct MenuButton: View {
        
        @EnvironmentObject var goalModel: GoalModel
        
        
        var body: some View {
            VStack {
                Rectangle()
                    .frame(width: 24, height: 5.5)
                    .rotationEffect(.zero)
                    .offset(y: 5)
                
                Rectangle()
                    .frame(width: 24, height: 5.5)
                    .rotationEffect(.zero)
                    .offset(y: 2)
            }
            .frame(width: 24, height: 24)
            .contentShape(Rectangle())
            .onTapGesture { goalModel.toggleMenuButton() }
        }
    }
}
