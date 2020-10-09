//
//  PopUpManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

class PopupManager: ObservableObject {
    
    static let shared = PopupManager()
    private init() {}
    
    
    @Published var isPresented: Bool = false

    @Published var type: OneSPopup<AnyView>.PopupType = .default
    @Published var position: OneSPopup<AnyView>.Position = .bottom

    @Published var autohideIn: Double? = nil
    @Published var closeOnTap: Bool = true
    @Published var closeOnTapOutside: Bool = true

    @Published var view: () -> AnyView = { AnyView(EmptyView()) }
    
    
    func showTextPopup(titleText: String, bodyText: String, backgroundColor: Color) {
        isPresented = true
        type = .default
        position = .bottom
        autohideIn = nil
        closeOnTap = true
        closeOnTapOutside = true
        view = {
            AnyView(OneSTextPopup(titleText: titleText, bodyText: bodyText, backgroundColor: backgroundColor))
        }
    }
    
    
    func showTextFieldPopup() {
        
    }
}
