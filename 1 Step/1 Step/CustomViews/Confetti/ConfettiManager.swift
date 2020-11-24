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
    @Published var amount: ConfettisAmout = .big
    
    
    func showConfetti(amount: ConfettisAmout) {
        show = true
        self.amount = amount
        DispatchQueue.main.asyncAfter(deadline: .now() + (amount == .big ? 5.0 : 3.0)) { self.show = false }
    }
}
