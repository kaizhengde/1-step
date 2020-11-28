//
//  FullSheetManager.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

final class FullSheetManager: ObservableObject {
    
    static let shared = FullSheetManager()
    private init() {}
    
    @Published var appear: Bool = false
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }

        
    func showFullSheet<T: View>(@ViewBuilder content: @escaping () -> T) {
        DispatchQueue.main.async {
            self.appear = true
            self.content = { AnyView(content()) }
        }
    }
    
    
    func dismiss() {
        self.appear = false
    }
}

