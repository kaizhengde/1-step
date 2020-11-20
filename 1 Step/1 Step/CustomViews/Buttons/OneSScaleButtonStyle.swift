//
//  OneSScaleButtonStyle.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

struct OneSScaleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.02 : 1)
    }
}


extension View {
    
    func oneSButtonScaleStyle() -> some View {
        self
            .buttonStyle(OneSScaleButtonStyle())
            .animation(.easeInOut(duration: 0.1))
    }
}
