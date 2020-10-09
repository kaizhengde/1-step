//
//  FloaterManager.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

final class FloaterManager: ObservableObject {
    
    static let shared = FloaterManager()
    private init() {}
    
    @Published var show: Bool = false
    
    @Published var floaterContent: () -> AnyView = { AnyView(EmptyView()) }
    
    
    //MARK: - Transition
    
    func showFloater() {
        show = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { self.dismissFloater() }
    }
    
    //MARK: - Show Floater
    
    func showTextFloater(titleText: String, bodyText: String, backgroundColor: Color) {
        showFloater()
        floaterContent = { AnyView(OneSTextFloater(titleText: titleText, bodyText: bodyText, backgroundColor: backgroundColor)) }
    }
    
    
    //MARK: - Dismiss Floater
    
    func dismissFloater() {
        show = false
        objectWillChange.send()
    }
}
