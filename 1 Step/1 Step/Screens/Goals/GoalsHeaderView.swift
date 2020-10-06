//
//  GoalsHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsHeaderView: View {
    
    var body: some View {
        VStack {
            OneSHeaderView("Goals", trailingButton: (.profile, .grayToBackground, { print("toProfile") }))
            TabBarView()
        }
    }
    
    
    private struct TabBarView: View {
        
        var body: some View {
            HStack(spacing: 4) {
                TabBarButtonView(tabBarActive: .left, text: "Active")
                TabBarButtonView(tabBarActive: .right, text: "Reached")
            }
            .frame(height: 36)
            .cornerRadius(20)
        }
        
        
        private struct TabBarButtonView: View {
            
            @EnvironmentObject var goalsModel: GoalsModel
            
            let tabBarActive: TabBarActive
            var isActive: Bool { goalsModel.tabBarCurrent == tabBarActive }
            
            let text: String
            var font: OneSFont { isActive ? .subtitle : .custom(font: Raleway.extraLight, size: 15) }
            var color: Color { isActive ? .grayToBackground : .neutralToDarkNeutral }
            
            
            var body: some View {
                HStack {
                    OneSTextView(text: text, font: font, color: color)
                        .padding(20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.darkBackgroundToBlack)
                .onTapGesture { switchIfNeeded() }
            }
            
            
            func switchIfNeeded() {
                if !isActive { goalsModel.tabBarCurrent = goalsModel.tabBarCurrent.toggle() }
            }
        }
    }
}
