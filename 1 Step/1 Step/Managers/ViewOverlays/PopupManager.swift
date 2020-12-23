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
    case resetAllData
    case shareApp
    
    //MARK: - Authorization
    case photoLibraryNoAccess
    case notificationsNoAccess
    
    //MARK: - Premium
    case premiumPurchased
    
    //MARK: - First
    case firstSelectMountain
    case firstSelectColor
    case firstOpenGoal
}


final class PopupManager: ViewOverlayManagerProtocol {
    
    static let shared = PopupManager()
    private init() {}
    
    @Published var transition: TransitionManager<PopupManager> = TransitionManager()
    @Published var currentKey: PopupKey!

    @Published var dismissOnTapOutside: Bool!
    @Published var dismissOnTapInside: Bool!
    @Published var tapDismissableDelay: DispatchTimeInterval!
    @Published var hapticFeedback: Bool!
    
    @Published var blurColor: Color!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var withPadding: Bool!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    let dismissed = PassthroughSubject<PopupKey, Never>()    
    let confirmBtnDismissed = PassthroughSubject<(key: PopupKey, input: String), Never>()
    
    
    
    //MARK: - Transition
    
    func initTransition() {
        if hapticFeedback { OneSFeedback.warning() }
        defaultInitTransition()
    }
    
    
    //MARK: - Show
    
    func showPopup<T: View>(
        _ key: PopupKey                             = .none,
        blurColor: Color                            = .opacityBlur,
        backgroundColor: Color,
        height: CGFloat                             = 360*Layout.multiplierWidth,
        withPadding: Bool                           = true,
        dismissOnTapOutside: Bool                   = true,
        dismissOnTapInside: Bool                    = false,
        tapDismissableDelay: DispatchTimeInterval   = .milliseconds(1_500),
        hapticFeedback: Bool                        = false,
        content: @escaping () -> T
    ) {
        DispatchQueue.main.async {
            self.hapticFeedback         = hapticFeedback
            self.initTransition()
            
            self.currentKey = key
            
            self.dismissOnTapOutside    = false
            self.dismissOnTapInside     = false
            self.tapDismissableDelay    = tapDismissableDelay
            DispatchQueue.main.asyncAfter(deadline: .now() + self.tapDismissableDelay) {
                self.dismissOnTapOutside    = dismissOnTapOutside
                self.dismissOnTapInside     = dismissOnTapInside
            }
  
            self.blurColor              = blurColor
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



