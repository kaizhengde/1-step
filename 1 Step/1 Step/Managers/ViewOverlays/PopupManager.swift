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
    @Published var continueButton: Bool!
    
    @Published var titleText: String!
    @Published var titleImage: Image?
    @Published var bodyText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Popups
    
    //TextPopup
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color, height: CGFloat = 300+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.dismissOnTap = true
        self.continueButton = false
        self.titleText = titleText
        self.titleImage = titleImage
        self.bodyText = bodyText
        self.backgroundColor = backgroundColor
        self.height = height
        self.content = { AnyView(OneSTextPopupView()) }
    }
    
    
    //TextField Popup
    
    var textFieldSave = ObjectWillChangePublisher()
    
    @Published var input: String!
    @Published var placerholder: String!
    @Published var inputColor: Color!
    @Published var placerholderColor: Color!
    @Published var inputLimit: Int!
    @Published var keyboard: UIKeyboardType!
    @Published var lowercased: Bool!
    
    func showTextFieldPopup(titleText: String, titleImage: Image? = nil, bodyText: String, input: String, placerholder: String, inputColor: Color, placerholderColor: Color, textLimit: Int, keyboard: UIKeyboardType = .default, lowercased: Bool = false, backgroundColor: Color, height: CGFloat = 300+Layout.onlyOniPhoneXType(40)) {
        initTransition()
        
        self.dismissOnTap = false
        self.continueButton = true
        self.titleText = titleText
        self.titleImage = titleImage
        self.bodyText = bodyText
        self.input = input
        self.placerholder = placerholder
        self.inputColor = inputColor
        self.placerholderColor = placerholderColor
        self.inputLimit = textLimit
        self.keyboard = keyboard
        self.lowercased = lowercased
        self.backgroundColor = backgroundColor
        self.height = height
        self.content = { AnyView(OneSTextFieldPopupView()) }
    }
    
    
    func saveAndDismiss() {
        textFieldSave.send()
        dismiss()
    }
}



