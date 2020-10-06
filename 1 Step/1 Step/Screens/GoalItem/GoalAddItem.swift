//
//  GoalAddItem.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalAddItem: View {
    
    @StateObject private var mainModel = MainModel.shared 
    
    
    var body: some View {
        Button(action: { mainModel.toScreen(.goalsAdd) }) {
            ZStack {
                SFSymbol.plus
                    .font(OneSFont.custom(weight: Raleway.light, size: 40).get())
                    .foregroundColor(.lightNeutralToLightGray)
            }
            .frame(width: 145 * ScreenSize.multiplierWidth, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.darkBackgroundToDarkGray, lineWidth: 1)
            )
        }
    }
}
