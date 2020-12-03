//
//  PremiumModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

final class PremiumModel: TransitionObservableObject {
    
    @Published var transition = TransitionManager<PremiumModel>()
    
    
    //MARK: - Transition
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: Animation.Delay.mountainAppear, fullHideAfter: .never)
        transition.delegate = self
        transition.state = .firstAppear
    }
}
