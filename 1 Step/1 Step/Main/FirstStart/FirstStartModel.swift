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
            userNameInput = userNameInput.removeWhiteSpaces()
        }
    }
    
    
    func finishFirstStart() {
        UserDefaultsManager.shared.firstStart = false
        UserDefaultsManager.shared.userName = userNameInput.removeWhiteSpaces()
        
        currentStep = .done
        DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.opacity) {
            MainModel.shared.toScreen(.goals)
        }
    }
    
    
    //MARK: - Mountain Animation
    
    var mountainOffsetY: CGFloat {
        switch currentStep {
        case .appear:       return MountainLayout.height
        case .one:          return MountainLayout.height*0.6 + Layout.onlyOniPhoneXType(MountainLayout.height*0.1)
        case .oneConfirm:   return MountainLayout.height*0.45
        case .two:          return MountainLayout.height*0.1 + Layout.onlyOniPhoneXType(MountainLayout.height*0.05)
        case .done:         return MountainLayout.height
        }
    }
}
