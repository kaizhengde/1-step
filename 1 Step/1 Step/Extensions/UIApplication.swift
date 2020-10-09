//
//  View.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

//MARK: - Hide Keyboard when tapped somewhere on screen

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}




