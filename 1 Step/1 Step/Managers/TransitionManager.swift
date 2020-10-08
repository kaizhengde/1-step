//
//  TransitionManager.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI
import Combine

protocol TransitionObservableObject: ObservableObject {
    
    func initTransition()
    func transitionFinishDelay() -> Double
}


class TransistionManager<TransitionDelegate> where TransitionDelegate: TransitionObservableObject, TransitionDelegate.ObjectWillChangePublisher == ObservableObjectPublisher {
    
    enum TransitionDelay {
        case none
        case mountain
        
        func get() -> DispatchTime {
            switch self {
            case .none: return .now() + .zero
            case .mountain: return .now() + AnimationDuration.mountainAppear
            }
        }
    }
    
    enum TransitionState {
        case hidden, appear, finish
    }
    
    weak var delegate: TransitionDelegate?
    
    var state: TransitionState = .hidden {
        didSet {
            if didAppear && !didFinish {
                DispatchQueue.main.asyncAfter(deadline: finishDelay.get()) {
                    self.state = .finish
                    self.delegate?.objectWillChange.send()
                }
            }
        }
    }
    var finishDelay: TransitionDelay
    
    
    init(finishDelay: TransitionDelay = .none) {
        self.finishDelay = finishDelay
    }
    
    
    var isHidden: Bool { state == .hidden }
    var didAppear: Bool { state == .appear || state == .finish }
    var didFinish: Bool { state == .finish }
}
