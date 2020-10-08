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
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
    }
}


extension Button {
    
    func oneSScaleStyle() -> some View {
        self
            .buttonStyle(OneSScaleButtonStyle())
            .animation(.easeInOut(duration: 0.1))
    }
}
