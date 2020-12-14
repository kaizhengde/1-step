//
//  View.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

//MARK: - Hide Keyboard when tapped somewhere on screen

extension UIApplication {
    
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
    
    
    func openOneSSettings() {
        DispatchQueue.main.async {
            self.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
}


extension UIApplication: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true 
    }
}


