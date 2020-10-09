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
    
    @State private var presenterContentRect: CGRect = .zero
    @State private var sheetContentRect: CGRect = .zero

    private var displayedOffset: CGFloat { -presenterContentRect.midY + ScreenSize.height/2 }

    var hiddenOffset: CGFloat {
        if presenterContentRect.isEmpty { return 1000 }
        return ScreenSize.height - presenterContentRect.midY + sheetContentRect.height/2 + 5
    }

    var currentOffset: CGFloat {
        return popupManager.transition.didAppear ? displayedOffset : hiddenOffset
    }

    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.presenterContentRect.integral {
                        DispatchQueue.main.async {
                            self.presenterContentRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            ).overlay(sheet())
    }

    
    func sheet() -> some View {
        return ZStack {
            if popupManager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
                    .onTapGesture { popupManager.dismissPopup() }
            }
            
            Group {
                OneSEmptyPopupView()
                    .offset(x: 0, y: currentOffset)
                
                popupManager.view()
                    .onTapGesture { popupManager.dismissPopup() }
                    .opacity(popupManager.transition.didFinish ? 1.0 : 0.0)
                    .oneSAnimation(duration: AnimationDuration.halfScreenOpacity)
            }
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.sheetContentRect.integral {
                        DispatchQueue.main.async {
                            self.sheetContentRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
            .frame(width: ScreenSize.width)
        }
        .oneSAnimation(duration: AnimationDuration.screenOpacity)
    }
}
