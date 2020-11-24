//
//  Scale.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

extension View {
    
    func oneSItemTapScale(with onTapBlock: @escaping () -> () = {}) -> some View {
        return modifier(OneSItemTapScale(onTapBlock: onTapBlock))
    }
}


fileprivate struct OneSItemTapScale: ViewModifier {
    
    @State private var tapAnimation = false
    let onTapBlock: () -> ()
    
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(tapAnimation ? 1.05 : 1.0)
            .onTapGesture {
                onTapBlock()
                tapAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
            }
    }
}


