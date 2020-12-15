//
//  Scale.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

extension View {
    
    func oneSItemScaleTapGesture(amount scale: CGFloat = 1.05, with onTapBlock: @escaping () -> () = {}) -> some View {
        return modifier(OneSItemSclaeTapGesture(scale: scale, onTapBlock: onTapBlock))
    }
}


fileprivate struct OneSItemSclaeTapGesture: ViewModifier {
    
    @State private var tapAnimation = false
    let scale: CGFloat
    let onTapBlock: () -> ()
    
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(tapAnimation ? scale : 1.0)
            .onTapGesture {
                onTapBlock()
                tapAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
            }
    }
}


