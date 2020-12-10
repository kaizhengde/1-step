//
//  GoalsHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @ObservedObject var goalsModel: GoalsModel
    
    
    var body: some View {
        VStack(spacing: Device.isiPhoneXType ? 8 : 5) {
            OneSHeaderView(Localized.goals, trailingButton: (.profile, .grayToBackground, { mainModel.toScreen(.profile) }))
            TabBarView(goalsModel: goalsModel)
        }
        .padding(.bottom, 24)
    }
    
    
    private struct TabBarView: View {
        
        @ObservedObject var goalsModel: GoalsModel
        
        
        var body: some View {
            HStack(spacing: 4) {
                TabBarButtonView(goalsModel: goalsModel, tabActive: .active, text: GoalsTab.active.description)
                TabBarButtonView(goalsModel: goalsModel, tabActive: .reached, text: GoalsTab.reached.description)
            }
            .frame(height: 38)
            .cornerRadius(20)
            .animation(nil)
        }
        
        
        private struct TabBarButtonView: View {
            
            @ObservedObject var goalsModel: GoalsModel
            
            let tabActive: GoalsTab
            var isActive: Bool { goalsModel.currentTab == tabActive }
            
            let text: String
            var font: OneSFont { isActive ? .subtitle : .custom(.extraLight, 15) }
            var color: Color { isActive ? .grayToBackground : .darkNeutralToNeutral }
            
            
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
                OneSFeedback.light()
                if !isActive { goalsModel.currentTab.toggle() }
            }
        }
    }
}
