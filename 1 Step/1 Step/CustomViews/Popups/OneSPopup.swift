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
            Color.opacityBlur.edgesIgnoringSafeArea(.all)
                .onTapGesture { manager.dismiss() }
            }
            
            if !manager.transition.isFullHidden {
            OneSPopupView()
                .onTapGesture { if manager.dismissOnTap { manager.dismiss() } }
                .opacity(manager.transition.isFullAppeared ? 1.0 : 0.0)
                .scaleEffect(manager.transition.isFullAppeared ? 1.0 : 0.0)
            }
        }
        .oneSAnimation(duration: AnimationDuration.opacity)
    }
    
    
    private struct OneSPopupView: View {
        
        @StateObject private var manager = PopupManager.shared
        
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .bottom) {
                        OneSSecondaryHeaderText(text: manager.titleText, color: .backgroundToGray)
                        if let titleImage = manager.titleImage {
                            titleImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        if manager.continueButton {
                            Spacer()
                            OneSContinueButton(color: .backgroundToGray, withScale: false) { manager.saveAndDismiss() }
                        }
                    }
                    manager.content()
                    Spacer()
                }
                Spacer()
            }
            .padding(Layout.firstLayerPadding)
            .padding(.vertical, 10)
            .padding(.top, manager.titleImage == nil ? 20 : 0)
            .frame(width: Layout.popoverWidth, height: manager.height)
            .background(manager.backgroundColor)
            .cornerRadius(20)
        }
    }
}
