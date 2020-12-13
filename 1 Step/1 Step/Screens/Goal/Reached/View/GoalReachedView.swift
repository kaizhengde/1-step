//
//  GoalReachedView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

struct GoalReachedView: View {
    
    @StateObject private var goalReachedModel = GoalReachedModel.shared
    let goalEditModel = GoalEditModel()

    
    var body: some View {
        Group {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .top) {
                    GoalReachedHeaderView()
                    
                    Group {
                        goalReachedModel.selectedGoal.color.standard.offset(y: Layout.screenHeight + 20)
                        VStack {
                            GoalReachedSummaryView()
                            
                            VStack(spacing: 50) {
                                JourneyView(state: .reached)

                                OneSSmallBorderButton(symbol: SFSymbol.delete, color: .backgroundToDarkGray) {
                                    goalEditModel.tryDelete(goalReachedModel.selectedGoal)
                                }
                            }
                            .padding(.top, -250)
                        }
                        .padding(.bottom, 180*Layout.multiplierHeight)
                    }
                }
            }
            .disabled(!goalReachedModel.transition.isFullAppeared)
        }
        .onReceive(PopupManager.shared.confirmBtnDismissed) { if $0.key == .goalDelete { goalEditModel.deleteGoalAndDismiss(goalReachedModel.selectedGoal) } }
    }
}
