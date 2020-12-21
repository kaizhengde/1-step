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
                        .font(.system(size: 40, weight: .light))
                        .foregroundColor(UserColor.user0.standard)
                        .offset(y: -16)
                        .opacity(manager.transition.isFullAppeared && showLock ? 1.0 : 0.0)
                        .oneSItemTransition()
                        .oneSItemScaleTapGesture(amount: 1.2) { tryAuthorize() }
                    
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
        OneSFeedback.light()
        AuthenticationManager.authorize(
            notPossible: {
                showLock = true
                errorText = "Biometric authentication failed. Make sure that you have your biometrics setup inside settings and turned on for 1 Step."
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
