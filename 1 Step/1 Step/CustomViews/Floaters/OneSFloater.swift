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


struct OneSFloater<FloaterContent>: ViewModifier where FloaterContent: View {
    
    @StateObject private var floaterManager = FloaterManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if floaterManager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
            }
            
            if !floaterManager.transition.isFullHidden {
                OneSFloaterView()
                    .opacity(floaterManager.transition.isFullAppeared ? 1.0 : 0.0)
                    .offset(y: floaterManager.transition.isFullAppeared ? 0 : -floaterManager.height-SafeAreaSize.top-8)
            }
        }
        .oneSAnimation(duration: AnimationDuration.opacity)
        .frame(maxHeight: .infinity)
    }
    
    
    private struct OneSFloaterView: View {
        
        @StateObject private var floaterManager = FloaterManager.shared
        
        
        var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        OneSText(text: floaterManager.titleText, font: .title2, color: .backgroundToGray)
                        floaterManager.content()
                    }
                    Spacer()
                }
                .padding(Layout.firstLayerPadding)
                .frame(width: Layout.floaterWidth, height: floaterManager.height)
                .background(floaterManager.backgroundColor)
                .cornerRadius(16)

                Spacer()
            }
            .padding(8)
        }
    }
}
