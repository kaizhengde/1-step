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
    @State private var floaterSize: CGSize = .zero
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if floaterManager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                floaterManager.floaterContent()
                    .opacity(floaterManager.transition.isFullAppeared ? 1.0 : 0.0)
                    .offset(y: floaterManager.transition.isFullAppeared ? 0 : -Layout.floaterHeight-SafeAreaSize.safeAreaTop-8)
                Spacer()
            }
            .padding(8)
        }
        .oneSAnimation(duration: AnimationDuration.opacity)
        .frame(maxHeight: .infinity)
    }
}
