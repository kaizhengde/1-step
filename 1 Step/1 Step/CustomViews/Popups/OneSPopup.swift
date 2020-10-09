//
//  OneSPopUp.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//  From https://github.com/exyte/PopupView customized
//

import SwiftUI

extension View {

    func oneSPopup() -> some View {
        self.modifier(OneSPopup<AnyView>())
    }

    
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}


struct OneSPopup<PopupContent>: ViewModifier where PopupContent: View {
    
    @StateObject private var popupManager = PopupManager.shared
    

    enum PopupType {

        case `default`
        case toast
        case floater(verticalPadding: CGFloat = 50)
    }
    

    enum Position {

        case top
        case bottom
    }


    /// holder for autohiding dispatch work (to be able to cancel it when needed)
    var dispatchWorkHolder = DispatchWorkHolder()

    // MARK: - Private Properties
    /// The rect of the hosting controller
    @State private var presenterContentRect: CGRect = .zero

    /// The rect of popup content
    @State private var sheetContentRect: CGRect = .zero

    /// The offset when the popup is displayed
    private var displayedOffset: CGFloat {
        switch popupManager.type {
        case .`default`:
            return  -presenterContentRect.midY + ScreenSize.height/2
        case .toast:
            if popupManager.position == .bottom {
                return ScreenSize.height - presenterContentRect.midY - sheetContentRect.height/2
            } else {
                return -presenterContentRect.midY + sheetContentRect.height/2
            }
        case .floater(let verticalPadding):
            if popupManager.position == .bottom {
                return ScreenSize.height - presenterContentRect.midY - sheetContentRect.height/2 - verticalPadding
            } else {
                return -presenterContentRect.midY + sheetContentRect.height/2 + verticalPadding
            }
        }
    }

    /// The offset when the popup is hidden
    var hiddenOffset: CGFloat {
        if popupManager.position == .top {
            if presenterContentRect.isEmpty {
                return -1000
            }
            return -presenterContentRect.midY - sheetContentRect.height/2 - 5
        } else {
            if presenterContentRect.isEmpty {
                return 1000
            }
            return ScreenSize.height - presenterContentRect.midY + sheetContentRect.height/2 + 5
        }
    }

    /// The current offset, based on the **presented** property
    var currentOffset: CGFloat {
        return popupManager.isPresented ? displayedOffset : hiddenOffset
    }

    // MARK: - Content Builders
    func body(content: Content) -> some View {
        content
            .applyIf(popupManager.closeOnTapOutside) {
                $0.simultaneousGesture(
                    TapGesture().onEnded {
                        popupManager.isPresented = false
                    })
            }
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

    /// This is the builder for the sheet content
    func sheet() -> some View {

        // if needed, dispatch autohide and cancel previous one
        if let autohideIn = popupManager.autohideIn {
            dispatchWorkHolder.work?.cancel()
            dispatchWorkHolder.work = DispatchWorkItem(block: {
                popupManager.isPresented = false
            })
            if popupManager.isPresented, let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + autohideIn, execute: work)
            }
        }

        return ZStack {
            Group {
                VStack {
                    VStack {
                        popupManager.view()
                            .simultaneousGesture(TapGesture().onEnded {
                                if popupManager.closeOnTap {
                                    self.dispatchWorkHolder.work?.cancel()
                                    popupManager.isPresented = false
                                }
                            })
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
                    }
                }
                .frame(width: ScreenSize.width)
                .offset(x: 0, y: currentOffset)
                .oneSAnimation()
            }
        }
    }
}


class DispatchWorkHolder {
    var work: DispatchWorkItem?
}
