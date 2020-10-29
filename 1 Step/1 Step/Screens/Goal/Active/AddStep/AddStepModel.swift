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
    
    @Published var selectedStep: (unit: Int, dual: Int) = (0, 0)
    @Published var stepsAddArray: (unit: [String], dual: [String]) = ([], [])

    
    //MARK: - Setup
    
    func setupAddStepView(_ noDrag: Bool, _ goal: Goal) {
        if noDrag {
            stepsAddArray = (goal.step.addArray, goal.step.addArrayDual)
            
            let selectedStepUnit = stepsAddArray.unit.count-1
            let selectedStepDual = stepsAddArray.dual.count-1
            
            selectedStep = (selectedStepUnit == -1 ? selectedStepDual : selectedStepUnit, selectedStepDual)
        } else {
            dragState = .hidden
        }
    }
    
    //MARK: - Data
    
    func tryAddStepsAndHide(with goal: Goal) {
        if DataModel.shared.addSteps(goal,
          stepUnits: Double(stepsAddArray.unit[selectedStep.unit])!,
          stepUnitsDual: Double(stepsAddArray.dual[selectedStep.dual])!
        ) {
            dragState = .hidden
        }
    }
    
    
    //MARK: - (Hidden) Rectangle
    
    //UI
    
    var dragHiddenScaleEffect: CGFloat {
        let progress = dragOffset/200
        return dragState == .show ? 0.5 : 1+progress
    }
    
    
    func hiddenForegroundColor(_ colorHidden: Color, _ colorOnDrag: Color) -> Color {
        let progress = -dragOffset/20
        return colorHidden.interpolateTo(color: colorOnDrag, fraction: Double(progress))
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
        return dragState == .hidden && value.translation.width <= -20
    }
}


extension VerticalAlignment {
    
    enum AddStepAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    
    static let addStepAlignment = Self(AddStepAlignment.self)
}
