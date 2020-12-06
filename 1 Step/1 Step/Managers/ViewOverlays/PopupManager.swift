//
//  PopUpManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI
import Combine

enum PopupKey {
    case none
    
    //MARK: - Journey
    case goalReached
    case journeyError
    
    //MARK: - Goal
    case goalCustomUnit
    case goalEnterInputError
    case goalDelete
    
    //MARK: - Profile
    case changeName
    
    //MARK: - Authorization
    case photoLibraryNoAccess
    case notificationsNoAccess
}


final class PopupManager: ViewOverlayManagerProtocol {
    
    static let shared = PopupManager()
    private init() {}
    
    @Published var transition: TransitionManager<PopupManager> = TransitionManager()
    @Published var currentKey: PopupKey!

    @Published var dismissOnTapOutside: Bool!
    @Published var hapticFeedback: Bool!
    
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var withPadding: Bool!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    let dismissed = PassthroughSubject<PopupKey, Never>()    
    let confirmBtnDismissed = PassthroughSubject<(key: PopupKey, input: String), Never>()
    
    private let tapDismissableDelay: DispatchTimeInterval = .milliseconds(1500)
    
    
    //MARK: - Transition
    
    func initTransition() {
        if hapticFeedback { OneSFeedback.warning() }
        defaultInitTransition()
    }
    
    
    //MARK: - Show
    
    func showPopup<T: View>(
        _ key: PopupKey             = .none,
        backgroundColor: Color,
        height: CGFloat             = 360*Layout.multiplierWidth,
        withPadding: Bool           = true,
        dismissOnTapOutside: Bool   = true,
        hapticFeedback: Bool        = false,
        content: @escaping () -> T
    ) {
        DispatchQueue.main.async {
            self.hapticFeedback         = hapticFeedback
            self.initTransition()
            
            self.currentKey = key
            
            self.dismissOnTapOutside    = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.tapDismissableDelay) {
                self.dismissOnTapOutside    = dismissOnTapOutside
            }
  
            self.backgroundColor        = backgroundColor
            self.height                 = height
            self.withPadding            = withPadding
            
            self.content                = { AnyView(content()) }
        }
    }
    
    
    //MARK: - Dismiss
    
    func dismiss() {
        if let key = currentKey {
            dismissed.send(key)
        }
        defaultDismiss()
    }
    
    
    func confirmBtnDismiss(with input: String) {
        confirmBtnDismissed.send((currentKey, input))
        dismiss()
    }
}



