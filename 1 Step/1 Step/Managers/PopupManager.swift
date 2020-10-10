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
    
    @Published var transition: TransitionManager<PopupManager> = TransitionManager(fullAppearAfter: DelayAfter.halfOpacity)

    @Published var popupContent: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Transition
    ///fullHide:    popupContent deinit (-> EmptyView())
    ///firstAppear: popupContent init + OpacityBlur appear
    ///fullAppear:  popupContent appear
    ///firstHide:   popupContent dismiss + OpacityBlur dismiss
    
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: DelayAfter.halfOpacity, fullHideAfter: DelayAfter.halfOpacity)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    func transitionDidFullHide() {
        popupContent = { AnyView(EmptyView()) }
    }
    
    
    //MARK: - Show Popup
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color) {
        initTransition()
        popupContent = {
            AnyView(OneSTextPopupView(titleText: titleText, titleImage: titleImage, bodyText: bodyText, backgroundColor: backgroundColor))
        }
    }
    
    
    //MARK: - Dismiss Popup
    
    func dismissPopup() {        
        transition.state = .firstHide
        objectWillChange.send()
        UIApplication.shared.endEditing()
    }
}



