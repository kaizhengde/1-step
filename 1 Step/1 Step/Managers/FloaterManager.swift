//
//  FloaterManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

final class FloaterManager: TransitionObservableObject {
    
    static let shared = FloaterManager()
    private init() {}
    
    @Published var transition: TransitionManager<FloaterManager> = TransitionManager(fullAppearAfter: DelayAfter.halfOpacity)
    
    @Published var floaterContent: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Transition
    ///fullHide:    floaterContent deinit (-> EmptyView())
    ///firstAppear: floaterContent init + OpacityBlur appear
    ///fullAppear:  floaterContent appear
    ///firstHide:   floaterContent dismiss + OpacityBlur dismiss
    

    func initTransition() {
        transition = TransitionManager(fullAppearAfter: DelayAfter.halfOpacity, fullHideAfter: DelayAfter.opacity)
        transition.delegate = self
        transition.state = .firstAppear
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5) { self.dismissFloater() }
    }
    
    
    func transitionDidFullHide() {
        floaterContent = { AnyView(EmptyView()) }
    }
    
    //MARK: - Show Floater
    
    func showTextFloater(titleText: String, bodyText: String, backgroundColor: Color) {
        initTransition()
        floaterContent = { AnyView(OneSTextFloater(titleText: titleText, bodyText: bodyText, backgroundColor: backgroundColor)) }
    }
    
    
    //MARK: - Dismiss Floater
    
    func dismissFloater() {
        transition.state = .firstHide
        objectWillChange.send()
    }
}
