//
//  TransitionManager.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI
import Combine

protocol TransitionObservableObject: ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
        
    var transition: TransistionManager<Self> { get set }
    
    func initTransition()
    func transitionDelay() -> Double
}


class TransistionManager<TransitionDelegate> where TransitionDelegate: TransitionObservableObject {
    
    enum TransitionState {
        case hidden, appear, finish, dismiss
    }
    
    weak var delegate: TransitionDelegate?
    
    var state: TransitionState = .hidden {
        didSet {
            if didAppear && !didFinish {
                DispatchQueue.main.asyncAfter(deadline: finishDelay) {
                    self.state = .finish
                    self.delegate?.objectWillChange.send()
                }
            }
        }
    }
    var finishDelay: DispatchTime
    
    
    init(finishDelay: DispatchTime = DelayAfter.none) {
        self.finishDelay = finishDelay
    }
    
    
    var isHidden: Bool { state == .hidden }
    var didAppear: Bool { state == .appear || state == .finish }
    var didFinish: Bool { state == .finish }
    var onDismiss: Bool { state == .dismiss }
}
