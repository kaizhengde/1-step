//
//  FirstStartModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class FirstStartModel: ObservableObject {
    
    enum Step {
        case appear, one, oneConfirm, two, done
    }
    
    @Published var userNameInput = ""
    @Published var currentStep: Step = .appear
    
    
    func toStepOneConfirm() {
        if !userNameInput.isEmpty && currentStep == .one {
            currentStep = .oneConfirm
        }
    }
    
    
    //MARK: - UI
    
    var currentStepText: String { "Step 1 of 2" }
    
    
    //MARK: - Mountain Animation
    
    var mountainOffsetY: CGFloat {
        switch currentStep {
        case .appear:       return MountainLayout.height
        case .one:          return MountainLayout.height*0.7
        case .oneConfirm:   return MountainLayout.height*0.5
        case .two:          return MountainLayout.height*0.2
        case .done:         return MountainLayout.height
        }
    }
}
