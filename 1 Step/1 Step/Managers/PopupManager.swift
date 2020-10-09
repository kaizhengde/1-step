//
//  PopUpManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

class PopupManager: TransitionObservableObject {

    static let shared = PopupManager()
    private init() {}
    
    @Published var transition: TransistionManager<PopupManager> = TransistionManager(finishDelay: DelayAfter.mountainAppear)

    @Published var view: () -> AnyView = { AnyView(EmptyView()) }
    @Published var viewBackgroundColor: Color = .backgroundToGray
    
    
    //MARK: - Transition
    
    func initTransition() {
        transition = TransistionManager(finishDelay: DelayAfter.halfScreenOpacity)
        transition.delegate = self
        transition.state = .appear
    }
    
    func transitionDelay() -> Double { return AnimationDuration.screenOpacity }
    
    
    //MARK: - Popups
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color) {
        initTransition()
        view = {
            AnyView(OneSTextPopupView(titleText: titleText, titleImage: titleImage, bodyText: bodyText))
        }
        viewBackgroundColor = backgroundColor
    }
    
    
    func showTextFieldPopup() {
        
    }
    
    
    func dismissPopup() {        
        transition.state = .dismiss
        view = { AnyView(EmptyView()) }
        
        UIApplication.shared.endEditing()
    }
}



