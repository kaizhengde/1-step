//
//  LoadingViewManager.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import SwiftUI

final class LoadingViewManager: ViewOverlayManagerProtocol {

    static let shared = LoadingViewManager()
    private init() {}
    
    @Published var transition: TransitionManager<LoadingViewManager> = TransitionManager()
    
    @Published var wheelColor: Color!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    
    func showLoadingView(wheelColor: Color) {
        DispatchQueue.main.async {
            self.initTransition()
            
            self.wheelColor = wheelColor
        }
    }
}

