//
//  GoalsScreenModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum TabActive {
    case left, right
    
    mutating func toggle() {
        if self == .left { self = .right }
        else { self = .left }
    }
}


class GoalsModel: ObservableObject {
    
    @Published var currentTab: TabActive = .left
}
