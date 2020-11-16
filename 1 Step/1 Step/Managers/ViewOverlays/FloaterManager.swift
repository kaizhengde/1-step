//
//  FloaterManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

final class FloaterManager: ViewOverlayManagerProtocol {

    static let shared = FloaterManager()
    private init() {}
    
    @Published var transition: TransitionManager<FloaterManager> = TransitionManager()
    
    @Published var titleText: String!
    @Published var bodyText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    

    //MARK: - Transition
    
    func initTransition() {
        defaultInitTransition()
        Feedback.haptic(type: .success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { self.dismiss() }
    }
    
    
    //MARK: - Floaters
    
    func showTextFloater(titleText: String, bodyText: String, backgroundColor: Color, height: CGFloat = 100*Layout.multiplierWidth) {
        initTransition()
        
        self.titleText = titleText
        self.bodyText = bodyText
        self.backgroundColor = backgroundColor
        self.height = height
        self.content = { AnyView(OneSTextFloater()) }
    }
}
