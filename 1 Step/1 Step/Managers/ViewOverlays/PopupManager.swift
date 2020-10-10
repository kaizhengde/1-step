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

    @Published var titleText: String!
    @Published var titleImage: Image?
    @Published var bodyText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Popups
    
    func showTextPopup(titleText: String, titleImage: Image? = nil, bodyText: String, backgroundColor: Color, height: CGFloat = 340*Layout.multiplierHeight) {
        initTransition()
        
        self.titleText = titleText
        self.titleImage = titleImage
        self.bodyText = bodyText
        self.backgroundColor = backgroundColor
        self.height = height
        self.content = {
            AnyView(OneSTextPopupView(bodyText: bodyText))
        }
    }
}



