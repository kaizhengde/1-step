//
//  InputAboveKeyboardManager.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

final class TextFieldAboveKeyboard: ObservableObject {
    
    static let shared = TextFieldAboveKeyboard()
    private init() {}
    
    @Published var appear: Bool = false
    
    @Published var placeholder: String!
    @Published var inputText: String!
    @Published var textLimit: Int?
    
    
    func showTextFieldAboveKeyboard(placeholder: String, inputText: String, textLimit: Int? = nil) {
        appear = true
        
        
    }
}
