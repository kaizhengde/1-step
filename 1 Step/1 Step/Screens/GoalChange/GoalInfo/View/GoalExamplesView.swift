//
//  GoalExamplesView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

struct GoalExamplesView: View {
    
    let selectedColor: UserColor

    
    var body: some View {
        VStack(spacing: 30) {
            OneSRowButton(.long, text: "Settings", accessoryCustomSymbol: Image("SettingsSymbol")) {}
            OneSRowButton(.long, text: "Share") {}
            
            OneSRowButton(.shortBig, text: "Plant a real tree 🌳", accessorySFSymbol: SFSymbol.plus) {}
            
            OneSRowButton(.shortSmall, text: "Premium", textColor: .whiteToDarkGray, backgroundColor: UserColor.user0.get(), accessoryText: "Yes!", accessoryColor: .whiteToDarkGray) {}
        }
    }
}
