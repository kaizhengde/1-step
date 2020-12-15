//
//  OneSConfetti.swift
//  1 Step
//
//  Created by Kai Zheng on 16.11.20.
//

import SwiftUI

extension View {

    func oneSConfetti() -> some View {
        self.modifier(OneSConfetti())
    }
}


fileprivate struct OneSConfetti: ViewModifier {
    
    @StateObject private var manager = ConfettiManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(
            Group {
                if manager.show {
                    ConfettiView(amount: manager.amount)
                        .allowsHitTesting(false)
                }
            }
        )
    }
}
