//
//  GoalCreateItem.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalCreateItem: View {
    
    @StateObject private var mainModel = MainModel.shared 
    
    
    var body: some View {
        Button(action: createItemTapped) {
            SFSymbol.plus
                .font(OneSFont.custom(.light, 40).font)
                .foregroundColor(.lightNeutralToLightGray)
                .frame(width: 145*Layout.multiplierWidth, height: 200)
                .contentShape(Rectangle())
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.lightNeutralToLightGray.opacity(0.5), lineWidth: 1)
                )
        }
    }
    
    
    private func createItemTapped() {
        if UserDefaultsManager.shared.settingPremium || DataModel.shared.activeGoals.count <= 1 {
            mainModel.toScreen(.goalAdd)
        } else {
            FullSheetManager.shared.showFullSheet {
                PremiumView()
            }
        }
    }
}
