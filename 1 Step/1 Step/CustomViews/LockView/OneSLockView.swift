//
//  OneSLockView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import SwiftUI

extension View {

    func oneSLockView() -> some View {
        self.modifier(OneSLockView())
    }
}


fileprivate struct OneSLockView: ViewModifier {
    
    @StateObject private var manager = LockViewManager.shared
    @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
    @State private var showLock = false
    @State private var errorText: String? = nil
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if manager.transition.didAppear {
                Color.whiteToDarkGray.edgesIgnoringSafeArea(.all)
                    .onAppear { tryAuthorize() }
            }
            
            if !manager.transition.isFullHidden {
                VStack {
                    SFSymbol.lock
                        .font(.system(size: 36, weight: .light))
                        .foregroundColor(UserColor.user0.standard)
                        .scaleEffect(infiniteAnimationManager.fast.isOnBackward ? 1.1 : 1.0)
                        .animation(InfiniteAnimationManager.fastAnimation)
                        .background(
                            Circle()
                                .foregroundColor(.backgroundToGray)
                                .frame(width: 100, height: 100)
                                .scaleEffect(infiniteAnimationManager.slow.isOnBackward ? 1.5: 1.0)
                                .animation(InfiniteAnimationManager.slowAnimation)
                        )
                        .offset(y: -20)
                        .opacity(manager.transition.isFullAppeared && showLock ? 1.0 : 0.0)
                        .oneSItemTransition()
                        .oneSItemScaleTapGesture(amount: 1.1) {
                            OneSFeedback.light()
                            tryAuthorize()
                        }
                    
                    if let text = errorText {
                        OneSBackgroundMultilineText(text: text)
                            .frame(height: 200)
                            .padding(Layout.secondLayerPadding)
                    }
                }
            }
        }
        .oneSAnimation()
    }
        
        
    private func tryAuthorize() {
        showLock = false
        BiometricsManager.authorize(
            unavailable: {
                showLock = true
                errorText = "\(BiometricsManager.getBiometricType().description!) \(Localized.Biometrics.error_unavailable)"
            },
            completion: { success in
                if success {
                    manager.dismiss()
                    if !MainModel.shared.appLaunched {
                        MainModel.shared.launchApp()
                    }
                } else {
                    showLock = true
                }
            }
        )
    }
}
