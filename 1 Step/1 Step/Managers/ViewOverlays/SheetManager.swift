//
//  SheetManager.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

final class SheetManager: ObservableObject {
    
    static let shared = SheetManager()
    private init() {}
    
    @Published var appear: Bool = false
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }

        
    func showSheet<T: View>(@ViewBuilder content: @escaping () -> T) {
        self.appear = true
        
        self.content = { AnyView(
            content()
                .oneSMiniSheet()
                .oneSPopup()
                .oneSFloater()
        ) }
    }
    
    
    func dismiss() {
        self.appear = false
    }
}
