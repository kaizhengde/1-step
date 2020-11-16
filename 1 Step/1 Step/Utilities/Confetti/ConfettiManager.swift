//
//  ConfettiManager.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

class ConfettiManager: ObservableObject {
    
    static let shared = ConfettiManager()
    private init() {}
    
    @Published var show: Bool = false
    
    
    func showConfetti() {
        show = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { self.show = false }
    }
}
