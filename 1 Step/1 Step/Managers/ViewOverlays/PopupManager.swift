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
    
    case goalReached
    case journeyError
    
    case goalCustomUnit
    case goalEnterInputError
    case goalDelete
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
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    let dismissed = PassthroughSubject<PopupKey, Never>()
    let buttonDismissed = PassthroughSubject<PopupKey, Never>()
    
    
    //MARK: - Popups
    
    //TextPopup
    
    func showTextPopup(_ key: PopupKey, titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color, height: CGFloat = 280+Layout.onlyOniPhoneXType(40), dismissOnTap: Bool = true) {
        initTransition()
        
        self.currentKey = key 
        
        self.dismissOnTap           = dismissOnTap
        self.dismissOnTapOutside    = true
        self.continueButton     	= false
        
        self.titleText          	= titleText
        self.titleImage         	= titleImage
        self.bodyText           	= bodyText
        
        self.backgroundColor    	= backgroundColor
        self.height             	= height
        self.content            	= { AnyView(OneSTextPopupView()) }
    }
    
    
    //TextField Popup
        
    @Published var input: String!
    
    @Published var placerholder: String!
    @Published var inputLimit: Int!
    @Published var keyboard: UIKeyboardType!
    @Published var lowercased: Bool!
    
    
    func showTextFieldPopup(_ key: PopupKey, titleText: String, bodyText: String, input: String, placerholder: String, textLimit: Int, keyboard: UIKeyboardType = .default, lowercased: Bool = false, backgroundColor: Color, height: CGFloat = 300+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.currentKey = key
        
        self.dismissOnTap           = false
        self.dismissOnTapOutside    = true
        self.continueButton         = true
        
        self.titleText              = titleText
        self.titleImage             = nil
        self.bodyText               = bodyText
        
        self.input                  = input
        self.placerholder           = placerholder
        self.inputLimit             = textLimit
        self.keyboard               = keyboard
        self.lowercased             = lowercased
        
        self.backgroundColor        = backgroundColor
        self.height                 = height
        self.content                = { AnyView(OneSTextFieldPopupView()) }
    }
    
    
    //TextField confirmation Popup
        
    @Published var confirmationInput: String! {
        didSet {
            if confirmationInput == confirmationText { continueButton = true }
            else { continueButton = false }
        }
    }
    @Published var confirmationText: String!
    
    
    func showTextFieldConfirmationPopup(_ key: PopupKey, titleText: String, bodyText: String, placerholder: String, textLimit: Int, confirmationText: String, backgroundColor: Color, height: CGFloat = 380+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.currentKey = key
        
        self.dismissOnTap           = false
        self.dismissOnTapOutside    = true
        self.continueButton         = false
        
        self.titleText              = titleText
        self.titleImage             = nil
        self.bodyText               = bodyText
        
        self.confirmationInput      = ""
        self.placerholder           = placerholder
        self.inputLimit             = textLimit
        self.confirmationText       = confirmationText
        
        self.backgroundColor        = backgroundColor
        self.height                 = height
        self.content                = { AnyView(OneSTextFieldConfirmationPopupView()) }
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



