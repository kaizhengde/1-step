//
//  PopUpManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

final class PopupManager: ViewOverlayManagerProtocol {
    
    static let shared = PopupManager()
    private init() {}
    
    @Published var transition: TransitionManager<PopupManager> = TransitionManager()

    @Published var dismissOnTap: Bool!
    @Published var dismissOnTapOutside: Bool!
    @Published var continueButton: Bool!
    @Published var continueAction: (() -> ())!
    
    @Published var titleText: String!
    @Published var titleImage: Image?
    @Published var bodyText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Popups
    
    //TextPopup
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color, height: CGFloat = 260+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.dismissOnTap           = true
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
    
    var textFieldSave = ObjectWillChangePublisher()
    
    @Published var input: String! 
    @Published var placerholder: String!
    @Published var inputLimit: Int!
    @Published var keyboard: UIKeyboardType!
    @Published var lowercased: Bool!
    
    
    func showTextFieldPopup(titleText: String, bodyText: String, input: String, placerholder: String, textLimit: Int, keyboard: UIKeyboardType = .default, lowercased: Bool = false, backgroundColor: Color, height: CGFloat = 300+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.dismissOnTap           = false
        self.dismissOnTapOutside    = true
        self.continueButton         = true
        self.continueAction         = { self.textFieldSave.send() }
        
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
    
    var textFieldConfirmation = ObjectWillChangePublisher()
    
    @Published var confirmationInput: String! {
        didSet {
            if confirmationInput == confirmationText { continueButton = true }
            else { continueButton = false }
        }
    }
    @Published var confirmationText: String!
    
    
    func showTextFieldConfirmationPopup(titleText: String, bodyText: String, placerholder: String, textLimit: Int, confirmationText: String, backgroundColor: Color, height: CGFloat = 380+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.dismissOnTap           = false
        self.dismissOnTapOutside    = true
        self.continueButton         = false
        self.continueAction         = { self.textFieldConfirmation.send() }
        
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
    
    
    func textFieldDismiss() {
        continueAction()
        dismiss()
    }
}



