//
//  OneSPopUp.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

extension View {

    func oneSPopup() -> some View {
        self.modifier(OneSPopup<AnyView>())
    }
}


fileprivate struct OneSPopup<PopupContent>: ViewModifier where PopupContent: View {
    
    @StateObject private var manager = PopupManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if manager.transition.didAppear {
            manager.blurColor.edgesIgnoringSafeArea(.all)
                .onTapGesture { if manager.dismissOnTapOutside { manager.dismiss() } }
            }
            
            if !manager.transition.isFullHidden {
            OneSPopupView()
                .opacity(manager.transition.isFullAppeared ? 1.0 : 0.0)
                .scaleEffect(manager.transition.isFullAppeared ? 1.0 : 0.01)
                .onTapGesture { if manager.dismissOnTapInside { manager.dismiss() } }
                .offset(y: -10*Layout.multiplierHeight)
            }
        }
        .oneSAnimation(duration: Animation.Duration.opacity)
    }
    
    
    private struct OneSPopupView: View {
        
        @StateObject private var manager = PopupManager.shared
        
        
        var body: some View {
            manager.content()
                .padding(manager.withPadding ? Layout.firstLayerPadding : 0)
                .frame(width: Layout.popoverWidth, height: manager.height)
                .background(manager.backgroundColor)
                .cornerRadius(15)
        }
    }
}
