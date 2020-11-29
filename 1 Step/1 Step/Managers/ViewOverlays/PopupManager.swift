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

    @Published var dismissOnTap: Bool!
    @Published var dismissOnTapOutside: Bool!
    @Published var continueButton: Bool!
    
    @Published var currentKey: PopupKey!
    
    @Published var titleText: String!
    @Published var titleImage: Image?
    @Published var bodyText: String!
    @Published var textColor: Color!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    let dismissed = PassthroughSubject<PopupKey, Never>()    
    let buttonDismissed = PassthroughSubject<PopupKey, Never>()
    
    private let tapDismissAllowedDelay: DispatchTimeInterval = .milliseconds(1500)
    
    
    //MARK: - Transition
    
    func initTransition() {
        Feedback.impact(style: .rigid)
        defaultInitTransition()
    }
    
    
    //MARK: - Popups
    
    //TextPopup
    
    @Published var bottomButtonText: String?
    
    
    func showTextPopup(
        _ key: PopupKey,
        titleText: String,
        titleImage: Image?          = nil,
        bodyText: String,
        textColor: Color            = .backgroundToGray,
        bottomButtonText: String    = "OK",
        backgroundColor: Color,
        height: CGFloat             = 360*Layout.multiplierWidth,
        dismissOnTap: Bool          = true,
        dismissOnTapOutside: Bool   = true
    ) {
        DispatchQueue.main.async {
            self.initTransition()
            
            self.currentKey = key
            
            self.dismissOnTap           = false
            self.dismissOnTapOutside    = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.tapDismissAllowedDelay) {
                self.dismissOnTap           = dismissOnTap
                self.dismissOnTapOutside    = dismissOnTapOutside
            }
            self.continueButton         = false
            
            self.titleText              = titleText
            self.titleImage             = titleImage
            self.bodyText               = bodyText
            self.textColor              = textColor
            self.bottomButtonText       = bottomButtonText
            
            self.backgroundColor        = backgroundColor
            self.height                 = height
            self.content                = { AnyView(OneSTextPopupView()) }
        }
    }
    
    
    //TextField Popup
        
    @Published var input: String!
    @Published var inputColor: Color!
    
    @Published var placeholder: String!
    @Published var placeholderColor: Color!
    @Published var inputLimit: Int!
    @Published var keyboard: UIKeyboardType!
    @Published var lowercased: Bool!
    
    
    func showTextFieldPopup(
        _ key: PopupKey,
        titleText: String,
        bodyText: String,
        textColor: Color            = .backgroundToGray,
        input: String,
        placeholder: String,
        placeholderColor: Color,
        textLimit: Int,
        keyboard: UIKeyboardType    = .default,
        lowercased: Bool            = false,
        backgroundColor: Color,
        height: CGFloat             = 360*Layout.multiplierWidth
    ) {
        DispatchQueue.main.async {
            self.initTransition()
            
            self.currentKey = key
            
            self.dismissOnTap           = false
            self.dismissOnTapOutside    = false
                DispatchQueue.main.asyncAfter(deadline: .now() + self.tapDismissAllowedDelay) {
                self.dismissOnTapOutside    = true
            }
            self.continueButton         = true
            
            self.titleText              = titleText
            self.titleImage             = nil
            self.bodyText               = bodyText
            self.textColor              = textColor
            self.bottomButtonText       = nil
            
            self.input                  = input
            self.placeholder            = placeholder
            self.placeholderColor       = placeholderColor
            self.inputLimit             = textLimit
            self.keyboard               = keyboard
            self.lowercased             = lowercased
            
            self.backgroundColor        = backgroundColor
            self.height                 = height
            self.content                = { AnyView(OneSTextFieldPopupView()) }
        }
    }
    
    
    //TextField confirmation Popup
        
    @Published var confirmationInput: String! {
        didSet {
            if confirmationInput == confirmationText { continueButton = true }
            else { continueButton = false }
        }
    }
    @Published var confirmationText: String!
    
    
    func showTextFieldConfirmationPopup(
        _ key: PopupKey,
        titleText: String,
        bodyText: String,
        textColor: Color            = .backgroundToGray,
        placeholder: String,
        placeholderColor: Color,
        textLimit: Int,
        confirmationText: String,
        backgroundColor: Color,
        height: CGFloat             = 400*Layout.multiplierWidth
    ) {
        DispatchQueue.main.async {
            self.initTransition()
            
            self.currentKey = key
            
            self.dismissOnTap           = false
            self.dismissOnTapOutside    = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.tapDismissAllowedDelay) {
                self.dismissOnTapOutside    = true
            }
            self.continueButton         = false
            
            self.titleText              = titleText
            self.titleImage             = nil
            self.bodyText               = bodyText
            self.textColor              = textColor
            self.bottomButtonText       = nil
            
            self.confirmationInput      = ""
            self.placeholder            = placeholder
            self.placeholderColor       = placeholderColor
            self.inputLimit             = textLimit
            self.confirmationText       = confirmationText
            
            self.backgroundColor        = backgroundColor
            self.height                 = height
            self.content                = { AnyView(OneSTextFieldConfirmationPopupView()) }
        }
    }
    
    
    //MARK: - Dismiss
    
    
    func dismiss() {
        dismissed.send(currentKey)
        defaultDismiss()
    }
    
    
    func buttonDismiss() {
        buttonDismissed.send(currentKey)
        dismiss()
    }
}



