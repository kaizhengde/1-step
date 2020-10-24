//
//  Shadow.swift
//  1 Step
//
//  Created by Kai Zheng on 12.10.20.
//

import SwiftUI

struct OneSShadow: ViewModifier {
    
    var opacity: Double
    var x: CGFloat
    var y: CGFloat
    var blur: CGFloat
    
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(opacity), radius: blur / 2.0, x: x, y: y)
    }
}


extension View {
    
    func oneSShadow(opacity: Double = 0.1, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4) -> some View {
        return modifier(OneSShadow(opacity: opacity, x: x, y: y, blur: blur))
    }
}
