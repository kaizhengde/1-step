//
//  LockViewManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import SwiftUI

final class LockViewManager: ViewOverlayManagerProtocol {

    static let shared = LockViewManager()
    private init() {}
    
    @Published var transition: TransitionManager<LockViewManager> = TransitionManager()
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    func showLockView() {
        DispatchQueue.main.async {
            self.initTransition()
        }
    }
}

