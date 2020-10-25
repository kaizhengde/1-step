//
//  AddStepModel.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

class AddStepModel: ObservableObject {
    
    enum DragState {
        case hidden, show
    }
    
    @Published var dragState: DragState = .hidden
    @Published var dragOffset: CGFloat = .zero
    
    
    //MARK: - (Hidden) Rectangle
    
    //UI
    
    var dragHiddenScaleEffect: CGFloat {
        let progress = dragOffset/200
        return dragState == .show ? 0.0 : 1+progress
    }
    
    var dragHiddenOpacity: Double {
        let progress = dragOffset/50
        return dragState == .show ? 0.0 : 1+Double(progress)
    }
    
    
    //Animation
    
    var animate: Bool {
        return InfiniteAnimationManager.shared.fast.isOnBackward && dragState == .hidden && dragOffset == 0
    }
    
    
    //Gesture
    
    lazy private(set) var dragGesture = DragGesture()
        .onChanged { [weak self] value in self?.onChanged(value) }
        .onEnded { [weak self] value in self?.onEnded(value) }
    
    
    private func onChanged(_ value: DragGesture.Value) {
        if legalDrag(value) {
            dragOffset = value.translation.width
            
            if onToShow(value) { dragState = .show }
        }
    }

    
    private func onEnded(_ value: DragGesture.Value) {
        if onToShow(value) { dragState = .show }
        dragOffset = .zero
    }
    
    //onChanged
    
    private func legalDrag(_ value: DragGesture.Value) -> Bool {
        return value.translation.width <= 0 && dragState == .hidden
    }
    
    //onEnded
    
    private func onToShow(_ value: DragGesture.Value) -> Bool {
        return dragState == .hidden && value.translation.width <= -50
    }
}
