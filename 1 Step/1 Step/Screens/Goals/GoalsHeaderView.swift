//
//  GoalsHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        VStack(spacing: Device.isiPhoneXType ? 8 : 3) {
            OneSHeaderView("Goals", trailingButton: (.profile, .grayToBackground, { mainModel.toScreen(.profile) }))
            TabBarView()
        }
        .padding(.bottom, 24)
    }
    
    
    private struct TabBarView: View {
        
        var body: some View {
            HStack(spacing: 4) {
                TabBarButtonView(tabActive: .active, text: GoalsTab.active.description)
                TabBarButtonView(tabActive: .reached, text: GoalsTab.reached.description)
            }
            .frame(height: 36)
            .cornerRadius(20)
            .animation(nil)
        }
        
        
        private struct TabBarButtonView: View {
            
            @EnvironmentObject private var goalsModel: GoalsModel
            
            let tabActive: GoalsTab
            var isActive: Bool { goalsModel.currentTab == tabActive }
            
            let text: String
            var font: OneSFont { isActive ? .subtitle : .custom(weight: Raleway.extraLight, size: 15) }
            var color: Color { isActive ? .grayToBackground : .neutralToDarkNeutral }
            
            
            var body: some View {
                HStack {
                    OneSText(text: text, font: font, color: color)
                        .padding(20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.darkBackgroundToBlack)
                .onTapGesture { switchIfNeeded() }
            }
            
            
            func switchIfNeeded() {
                if !isActive { goalsModel.currentTab.toggle() }
            }
        }
    }
}
