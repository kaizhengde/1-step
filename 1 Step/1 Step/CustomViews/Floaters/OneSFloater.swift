//
//  OneSFloater.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

extension View {

    func oneSFloater() -> some View {
        self.modifier(OneSFloater<AnyView>())
    }
}


struct OneSFloater<FloaterContent>: ViewModifier where FloaterContent: View {
    
    @StateObject private var floaterManager = FloaterManager.shared
    @State private var floaterSize: CGSize = .zero
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        VStack {
            ChildSizeReader(size: $floaterSize) {
                floaterManager.floaterContent()
                    .opacity(floaterManager.show ? 1.0 : 0.0)
                    .offset(y: floaterManager.show ? 0 : -floaterSize.height-Layout.firstLayerWidth)
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding(8)
    }
}
