//
//  JourneyAnimationHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 15.11.20.
//

import SwiftUI

class JourneyAnimationHandler: ObservableObject {
    
    static let shared = JourneyAnimationHandler()
    private init() {}
    
    
    //MARK: - MilestoneChange
    
    enum MilestoneChangeState {
        case none
        case closeFinished
        case openNewAndScrollToCurrent
    }

    
    @Published var milestoneChangeState: MilestoneChangeState = .none {
        didSet {
            if milestoneChangeState == .openNewAndScrollToCurrent {
                GoalModel.shared.setScrollPosition.send(.current)
            }
        }
    }
    
    
    func startMilestoneChange() {
        milestoneChangeState = .closeFinished
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
        }
    }
}
