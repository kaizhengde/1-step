//
//  GoalHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 17.10.20.
//

import SwiftUI

struct GoalHeaderView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var sheetManager = SheetManager.shared
    
    
    var body: some View {
        VStack {
            OneSHeaderView(leadingButton: (.custom(AnyView(MenuButton())), goalModel.headerButtonColor, { goalModel.toggleMenuButton() }),
                           trailingButton: (.settings, goalModel.headerButtonColor, { sheetManager.showSheet(dragToHide: false) { GoalEditScreen().environmentObject(goalModel) } } ))
            Spacer()
        }
        .padding(.horizontal, Layout.firstLayerPadding)
        .opacity(!goalModel.transition.isFullHidden ? 1.0 : 0.0)
        .offset(y: !goalModel.transition.isFullHidden ? 0 : -30)
        .oneSAnimation()
    }
    
    
    private struct MenuButton: View {
        
        @StateObject private var goalModel = GoalModel.shared
        
        
        var body: some View {
            VStack {
                Rectangle()
                    .frame(width: 25, height: 5.5)
                    .rotationEffect(goalModel.menuButtonRotationDegree(45))
                    .offset(y: goalModel.menuButtonRotationOffset(standard: 5, menu: 9.5))
                
                Rectangle()
                    .frame(width: 25, height: 5.5)
                    .rotationEffect(goalModel.menuButtonRotationDegree(-45))
                    .offset(y: goalModel.menuButtonRotationOffset(standard: 2, menu: -4))
            }
            .frame(width: 25, height: 25)
            .contentShape(Rectangle())
        }
    }
}
