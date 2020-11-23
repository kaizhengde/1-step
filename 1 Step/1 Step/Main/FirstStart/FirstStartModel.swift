//
//  FirstStartModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class FirstStartModel: ObservableObject {
    
    enum Step {
        case initial, one, oneEntered, two, finished
    }
    
    @Published var userNameInput: String = ""
    @Published var currentStep: Step = .initial
    
    
    //MARK: - UI
    
    var currentStepText: String { "Step 1 of 2" }
    
    var mountainOffsetY: CGFloat {
        switch currentStep {
        case .initial:      return MountainLayout.height
        case .one:          return MountainLayout.height - MountainLayout.height/4
        case .oneEntered:   return MountainLayout.height/2
        case .two:          return MountainLayout.height/6
        case .finished:     return MountainLayout.height
        }
    }
    
}
