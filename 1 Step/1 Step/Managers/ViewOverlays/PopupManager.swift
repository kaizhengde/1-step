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
    @Published var titleText: String!
    @Published var bodyText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Popups
    
    @Published var titleImage: Image?
    
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color, height: CGFloat = 340*Layout.multiplierHeight) {
        initTransition()
        
        self.dismissOnTap = true
        self.titleText = titleText
        self.titleImage = titleImage
        self.bodyText = bodyText
        self.backgroundColor = backgroundColor
        self.height = height
        self.content = {
            AnyView(OneSTextPopupView())
        }
    }
    
    
    @Published var input: Binding<String>!
    @Published var placerholder: String!
    @Published var inputColor: Color!
    @Published var placerholderColor: Color!
    @Published var inputLimit: Int!
    @Published var keyboard: UIKeyboardType!
    @Published var lowercased: Bool!
    
    func showTextFieldPopup(titleText: String, bodyText: String, input: Binding<String>, placerholder: String, inputColor: Color, placerholderColor: Color, textLimit: Int, keyboard: UIKeyboardType = .default, lowercased: Bool = false, backgroundColor: Color, height: CGFloat = 340*Layout.multiplierHeight) {
        initTransition()
        
        self.dismissOnTap = false 
        self.titleText = titleText
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
        self.content = {
            AnyView(OneSTextFieldPopupView())
        }
    }
}



