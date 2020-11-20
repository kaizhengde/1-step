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
        VStack(alignment: .leading, spacing: 30) {
            OneSRowButton(.long, title: "Settings", accessoryCustomSymbol: Image("SettingsSymbol")) {}
            OneSRowButton(.long, title: "Share") {}
            
            OneSRowButton(.shortBig, title: "Plant a real tree 🌳", accessorySFSymbol: SFSymbol.plus) {}
            
            OneSRowButton(.shortSmall, title: "Premium", textColor: .whiteToDarkGray, backgroundColor: UserColor.user0.get(), accessoryText: "Yes!", accessoryColor: .whiteToDarkGray) {}
            
            OneSDropDown(.long, title: "Data & Privacy", accessorySFSymbol: SFSymbol.delete) {
                VStack(spacing: 10) {
                    OneSRowButton(.shortSmall, title: "Premium", textColor: .whiteToDarkGray, backgroundColor: UserColor.user0.get(), accessoryText: "Yes!", accessoryColor: .whiteToDarkGray) {}
                    OneSDropDown(.shortSmall, title: "Language", accessoryText: "English", accessoryColor: UserColor.user0.get()) {
                        VStack(spacing: 10) {
                            OneSRowSelectButton(.constant(false), title: "German", selectedColor: UserColor.user0.get()) {}
                            OneSRowSelectButton(.constant(true), title: "English", selectedColor: UserColor.user0.get()) {}
                            OneSRowSelectButton(.constant(false), title: "Chinese", selectedColor: UserColor.user0.get()) {}
                            OneSRowSelectButton(.constant(false), title: "French", selectedColor: UserColor.user0.get()) {}
                        }
                    }
                    
                    OneSRowButton(.shortSmall, title: "Darkmode", accessoryText: "Off", accessoryColor: UserColor.user0.get()) {}
                    OneSRowButton(.shortSmall, title: "Notifications", textColor: .whiteToDarkGray, backgroundColor: UserColor.user0.get(), accessoryText: "On", accessoryColor: .whiteToDarkGray) {}
                }
            }
            
            OneSDropDown(.shortBig, title: "Data & Privacy") {
                VStack(spacing: 10) {
                    HStack {
                        OneSText(text: "I want to...", font: .custom(weight: Raleway.semiBold, size: 20), color: .grayToBackground)
                        Spacer()
                    }
                    
                    GoalInfoBackgroundText(text: "Lose weight", backgroundColor: selectedColor.get(.light), big: true)
                    GoalInfoArrowText(text: "What?", big: true)
                    
                    GoalInfoBackgroundText(text: "Lose 20 pounds", backgroundColor: selectedColor.get(.light), big: true)
                    GoalInfoArrowText(text: "How?", big: true)
                    
                    GoalInfoBackgroundText(text: "Exercise more often", backgroundColor: selectedColor.get(.light), big: true)
                    GoalInfoArrowText(text: "What?", big: true)
                    
                    GoalInfoBackgroundText(text: "Go for a run regularly", backgroundColor: selectedColor.get(.light), big: true)
                    GoalInfoArrowText(text: "What?", big: true)
                    
                    GoalInfoBackgroundText(text: "Run 100 miles in total", backgroundColor: selectedColor.get(), big: true)
                }
            }
        }
        .padding(.bottom, 400)
    }
}
