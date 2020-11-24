//
//  Appear.swift
//  1 Step
//
//  Created by Kai Zheng on 20.11.20.
//

import SwiftUI

extension View {
    
    func oneSItemTransition(_ appear: Binding<Bool>) -> some View {
        return modifier(OneSItemTransitionModifier(appear: appear))
    }
    
    
    func oneSItemTransition(after delay: DispatchTimeInterval = Animation.Delay.none) -> some View {
        return modifier(OneSItemTransition(delay: delay))
    }
}


fileprivate struct OneSItemTransitionModifier: ViewModifier {
    
    @Binding var appear: Bool
    
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(appear ? 1 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
    }
}


fileprivate struct OneSItemTransition: ViewModifier {
    
    @State private var appear = false
    let delay: DispatchTimeInterval
    
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(appear ? 1 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
            .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + delay) { appear = true } }
    }
}

