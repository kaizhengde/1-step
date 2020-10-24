//
//  InfiniteAnimationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 24.10.20.
//

import SwiftUI
import Combine

final class InfinteAnimationManager: ObservableObject {

    enum AnimationState {
        
        case onForward, onBackward
        
        mutating func toggle() {
            self = self == .onForward ? .onBackward : .onForward
        }
        
        var isOnForward: Bool { return self == .onForward }
        var isOnBackward: Bool { return self == .onBackward }
    }
    
    static let shared = InfinteAnimationManager()
    
    static let slowAnimation: Animation = .easeInOut(duration: 1.2)
    static let fastAnimation: Animation = .easeInOut(duration: 0.2)
    
    @Published var timer: AnyCancellable!
    
    @Published var slow: AnimationState = .onForward
    @Published var fast: AnimationState = .onForward
    
    
    private init() {
        timer = Timer.publish(every: 3.6, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.slow.toggle()
                self.fast.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200)) {
                    self.slow.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                    self.fast.toggle()
                }
            }
    }
}
