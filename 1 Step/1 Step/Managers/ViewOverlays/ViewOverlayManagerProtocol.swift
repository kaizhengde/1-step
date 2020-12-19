//
//  ViewOverlayManagerProtocol.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

enum ViewOverlayPlace {
    case view, sheet
}

protocol ViewOverlayManagerProtocol: TransitionObservableObject {
    
    static var shared: Self { get }
    
    var content: () -> AnyView { get set }
    
    func dismiss()
}

extension ViewOverlayManagerProtocol {
    
    ///fullHide:    content deinit (-> EmptyView())
    ///firstAppear: content init + OpacityBlur appear
    ///fullAppear:  content appear
    ///firstHide:   content dismiss + OpacityBlur dismiss
    
    
    func initTransition() { defaultInitTransition() }
    func defaultInitTransition() {
        transition = TransitionManager(fullAppearAfter: Animation.Delay.halfOpacity, fullHideAfter: Animation.Delay.opacity)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    func transitionDidFullHide() {
        content = { AnyView(EmptyView()) }
    }
    
    
    func dismiss() { defaultDismiss() }
    func defaultDismiss() {
        transition.state = .firstHide
        DispatchQueue.main.async { self.objectWillChange.send() }
    }
}
