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


struct OneSPopup<PopupContent>: ViewModifier where PopupContent: View {
    
    @StateObject private var popupManager = PopupManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if popupManager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
                    .onTapGesture { popupManager.dismissPopup() }
            }
            
            popupManager.popupContent() 
                .onTapGesture { popupManager.dismissPopup() }
                .opacity(popupManager.transition.didFinish ? 1.0 : 0.0)
                .scaleEffect(popupManager.transition.didFinish ? 1.0 : 0.0)
        }
        .oneSAnimation(duration: AnimationDuration.screenOpacity)
    }
}
