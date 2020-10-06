//
//  MainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum ActiveScreen {
    case goals
    case goal
    case goalsAdd
    case profile
}


class MainModel: ObservableObject {
    
    static let shared = MainModel()
    private init() {} 
    
    @Published private(set) var activeScreen: ActiveScreen = .goals
    func toScreen(_ screen: ActiveScreen) { activeScreen = screen }
}
