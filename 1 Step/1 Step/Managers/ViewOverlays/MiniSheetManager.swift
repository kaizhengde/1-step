//
//  MiniSheetManager.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

final class MiniSheetManager: ViewOverlayManagerProtocol {
    
    static let shared = MiniSheetManager()
    private init() {}
    
    @Published var transition: TransitionManager<MiniSheetManager> = TransitionManager()

    var titleText: String!
    @Published var backgroundColor: Color!
    @Published var height: CGFloat!
    @Published var content: () -> AnyView = { AnyView(EmptyView()) }
    
    let extraHeight: CGFloat = 60

    
    //MARK: - MiniSheets
    
    func showCustomMiniSheet<T: View>(backgroundColor: Color, height: CGFloat, @ViewBuilder content: @escaping () -> T) {
        DispatchQueue.main.async {
            self.initTransition()
        
            self.titleText = ""
            self.backgroundColor = backgroundColor
            self.height = height
            self.content = { AnyView(content()) }
        }
    }
}
