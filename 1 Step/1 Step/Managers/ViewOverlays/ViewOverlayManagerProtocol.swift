//
//  ViewOverlayManagerProtocol.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI 

protocol ViewOverlayManagerProtocol: TransitionObservableObject {
    
    static var shared: Self { get }
    
    var titleText: String! { get set }
    var backgroundColor: Color! { get set }
    var height: CGFloat! { get set }
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
        DispatchQueue.main.async {
            self.transition = TransitionManager(fullAppearAfter: DelayAfter.halfOpacity, fullHideAfter: DelayAfter.opacity)
            self.transition.delegate = self
            self.transition.state = .firstAppear
        }
    }
    
    
    func transitionDidFullHide() {
        content = { AnyView(EmptyView()) }
    }
    
    
    func dismiss() {
        transition.state = .firstHide
        objectWillChange.send()
    }
}
