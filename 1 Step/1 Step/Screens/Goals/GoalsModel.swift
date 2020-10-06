//
//  GoalsScreenModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum TabBarActive {
    case left, right
    
    func toggle() -> Self { return self == .left ? .right : .left }
}


class GoalsModel: ObservableObject {
    
    @Published var tabBarCurrent: TabBarActive = .left
}
