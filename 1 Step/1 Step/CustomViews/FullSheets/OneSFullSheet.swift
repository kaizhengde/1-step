//
//  OneSFullSheet.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

extension View {

    func oneSFullSheet() -> some View {
        self.modifier(OneSFullSheet<AnyView>())
    }
}

fileprivate struct OneSFullSheet<FullSheetContent>: ViewModifier where FullSheetContent: View {
    
    @StateObject private var manager = FullSheetManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if manager.appear {
                manager.content()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
