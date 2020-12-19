//
//  OneSLoadingView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import SwiftUI

extension View {

    func oneSLoadingView() -> some View {
        self.modifier(OneSLoadingView())
    }
}


fileprivate struct OneSLoadingView: ViewModifier {
    
    @StateObject private var manager = LoadingViewManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if manager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
            }
            
            if !manager.transition.isFullHidden {
                ProgressView()
                    .opacity(manager.transition.isFullAppeared ? 1.0 : 0.0)
                    .progressViewStyle(CircularProgressViewStyle(tint: manager.wheelColor))
                    .scaleEffect(manager.transition.isFullAppeared ? 1.7 : 0.0, anchor: .center)
            }
        }
        .oneSAnimation(duration: Animation.Duration.opacity)
    }
}
