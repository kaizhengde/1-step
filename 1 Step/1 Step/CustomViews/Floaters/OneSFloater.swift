//
//  OneSFloater.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

extension View {

    func oneSFloater() -> some View {
        self.modifier(OneSFloater<AnyView>())
    }
}


fileprivate struct OneSFloater<FloaterContent>: ViewModifier where FloaterContent: View {
    
    @StateObject private var manager = FloaterManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if !manager.transition.isFullHidden {
                OneSFloaterView()
                    .opacity(manager.transition.isFullAppeared ? 1.0 : 0.0)
                    .offset(y: manager.transition.isFullAppeared ? 0 : -manager.height-SafeAreaSize.top-8)
            }
        }
        .oneSAnimation(duration: Animation.Duration.opacity)
        .frame(maxHeight: .infinity)
    }
    
    
    private struct OneSFloaterView: View {
        
        @StateObject private var manager = FloaterManager.shared
        
        
        var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        OneSText(text: manager.titleText, font: .title2, color: .backgroundToGray)
                        manager.content()
                    }
                    Spacer()
                }
                .padding(Layout.firstLayerPadding)
                .frame(width: Layout.floaterWidth, height: manager.height)
                .background(manager.backgroundColor)
                .cornerRadius(16)
                .oneSShadow(opacity: 0.15, blur: 10)
                .padding(.top, Layout.screenTopPadding)

                Spacer()
            }
            .padding(8)
        }
    }
}
