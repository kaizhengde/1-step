//
//  PopUpManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

final class PopupManager: TransitionObservableObject {
    
    static let shared = PopupManager()
    private init() {}
    
    @Published var transition: TransistionManager<PopupManager> = TransistionManager(finishDelay: DelayAfter.mountainAppear)

    @Published var popupContent: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Transition
    
    func initTransition() {
        transition = TransistionManager(finishDelay: DelayAfter.halfScreenOpacity)
        transition.delegate = self
        transition.state = .appear
    }
    
    func transitionDelay() -> Double { return AnimationDuration.screenOpacity }
    
    
    //MARK: - Show Popup
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color) {
        initTransition()
        popupContent = {
            AnyView(OneSTextPopupView(titleText: titleText, titleImage: titleImage, bodyText: bodyText, backgroundColor: backgroundColor))
        }
    }
    
    
    //MARK: - Dismiss Popup
    
    func dismissPopup() {        
        transition.state = .dismiss
        objectWillChange.send()
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: DelayAfter.halfScreenOpacity) { self.popupContent = { AnyView(EmptyView()) } }
    }
}



