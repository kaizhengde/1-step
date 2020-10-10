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
                .onTapGesture { popupManager.dismiss() }
            }
            
            if !popupManager.transition.isFullHidden {
            OneSPopupView()
                .onTapGesture { popupManager.dismiss() }
                .opacity(popupManager.transition.isFullAppeared ? 1.0 : 0.0)
                .scaleEffect(popupManager.transition.isFullAppeared ? 1.0 : 0.0)
            }
        }
        .oneSAnimation(duration: AnimationDuration.opacity)
    }
    
    
    private struct OneSPopupView: View {
        
        @StateObject private var popupManager = PopupManager.shared
        
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .bottom) {
                        OneSSecondaryHeaderText(text: popupManager.titleText, color: .backgroundToGray)
                        if let titleImage = popupManager.titleImage {
                            titleImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                    }
                    popupManager.content()
                    Spacer()
                }
                Spacer()
            }
            .padding(Layout.firstLayerPadding)
            .padding(.vertical, 10)
            .padding(.top, popupManager.titleImage == nil ? 20 : 0)
            .frame(width: Layout.popoverWidth, height: popupManager.height)
            .background(popupManager.backgroundColor)
            .cornerRadius(20)
        }
    }
}
