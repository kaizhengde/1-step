//
//  TransitionManager.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI
import Combine

protocol TransitionObservableObject: ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
        
    var transition: TransitionManager<Self> { get set }
    
    func initTransition()
    
    func transitionDidFullAppear()
    func transitionDidFullHide()
}

extension TransitionObservableObject {
    
    func transitionDidFullAppear() {}
    func transitionDidFullHide() {}
}


final class TransitionManager<TransitionDelegate> where TransitionDelegate: TransitionObservableObject {
    
    enum TransitionState {
        case fullHide, firstAppear, fullAppear, firstHide
    }
    
    weak var delegate: TransitionDelegate?
    
    var state: TransitionState = .fullHide {
        didSet {
            if didAppear && !isFullAppeared {
                DispatchQueue.main.asyncAfter(deadline: .now() + fullAppearAfter) {
                    self.state = .fullAppear
                    self.delegate?.transitionDidFullAppear()
                    self.delegate?.objectWillChange.send()
                }
            }
            
            if didHide && !isFullHidden {
                DispatchQueue.main.asyncAfter(deadline: .now() + fullHideAfter) {
                    self.state = .fullHide
                    self.delegate?.transitionDidFullHide() 
                    self.delegate?.objectWillChange.send()
                }
            }
        }
    }
    
    var fullAppearAfter: DispatchTimeInterval
    var fullHideAfter: DispatchTimeInterval
    
    
    init(fullAppearAfter: DispatchTimeInterval = .seconds(0), fullHideAfter: DispatchTimeInterval = .seconds(0)) {
        self.fullAppearAfter = fullAppearAfter
        self.fullHideAfter = fullHideAfter
    }
    
    //Only dissappear if == fullHide
    var isFullHidden: Bool { state == .fullHide }
    
    //Appear on both
    var didAppear: Bool { state == .firstAppear || state == .fullAppear }
    
    //Only appear if == fullAppear
    var isFullAppeared: Bool { state == .fullAppear }
    
    //Disappear on both
    var didHide: Bool { state == .firstHide || state == .fullHide }
}
