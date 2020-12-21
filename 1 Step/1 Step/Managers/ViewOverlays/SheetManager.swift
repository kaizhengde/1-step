//
//  SheetManager.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI
import Introspect

final class SheetManager: ObservableObject {
    
    static let shared = SheetManager()
    private init() {}
    
    @Published var appear: Bool = false
    @Published var dragToHide: Bool = true
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }

        
    func showSheet<T: View>(dragToHide: Bool = true, @ViewBuilder content: @escaping () -> T) {
        DispatchQueue.main.async {
            self.appear = true
            self.dragToHide = dragToHide
            
            self.content = { AnyView(
                content()
                    .oneSMiniSheet()
                    .oneSPopup()
                    .oneSFloater()
                    .oneSConfetti()
                    .oneSLoadingView()
                    .oneSLockView()
                    .introspectViewController { $0.isModalInPresentation = !dragToHide }
            ) }
        }
    }
    
    
    func dismiss() {
        self.appear = false
    }
}
