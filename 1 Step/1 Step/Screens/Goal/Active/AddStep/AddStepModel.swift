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
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    var journeyAddStepsHandler = JourneyAddStepsHandler.shared

    
    //MARK: - Setup
    
    func setupAddStepView(_ noDrag: Bool) {
        if noDrag {
            let selectedStepUnit = goal.step.addArrayLastIndex
            let selectedStepDual = goal.step.addArrayDualLastIndex
            
            selectedStep = (goal.step.addArray.isEmpty ? selectedStepDual : selectedStepUnit, selectedStepDual)
        } else {
            dragState = .hidden
        }
    }
    
    //MARK: - Data
    
    func addButtonPressed() {
        switch tryAddStepsAndHide() {
        case .goalDone:
            break
        case let .milestoneChange(forward: forward):
            journeyAddStepsHandler.startMilestoneChange(forward: forward)
            break
        case .normal:
            journeyAddStepsHandler.startNormalAdd()
            break
        }
        GoalModel.shared.objectWillChange.send()
    }
    
    
    func tryAddStepsAndHide() -> JourneyAddStepsHandler.AddStepsResult {
        
        var stepAddArray        = goal.step.addArray
        var stepAddArrayDual    = goal.step.addArrayDual
        
        var selectedStepUnit    = selectedStep.unit == -1 ? goal.step.addArrayLastIndex : selectedStep.unit
        var selectedStepDual    = selectedStep.dual == -1 ? goal.step.addArrayDualLastIndex : selectedStep.dual
        
        if stepAddArray.isEmpty {
            stepAddArray = ["0"]
            selectedStepUnit = 0
        }
        if stepAddArrayDual.isEmpty {
            stepAddArrayDual = ["0"]
            selectedStepDual = 0
        }
        
        let newStepUnits = calculateStepUnitsToBeAdded(Double(stepAddArray.reversed()[selectedStepUnit])!, Double(stepAddArrayDual.reversed()[selectedStepDual])!)
        
        let addStepsResult = journeyAddStepsHandler.getAddStepsResult(with: newStepUnits)
        
        if addStepsResult.isMilestoneChange {
            DispatchQueue.main.asyncAfter(deadline: .now() + journeyAddStepsHandler.after(.closeFinished)) {
                if DataModel.shared.addSteps(self.goal, with: newStepUnits) {}
            }
        } else {
            if DataModel.shared.addSteps(goal, with: newStepUnits) {}
        }
        
        dragState = .hidden
        
        return addStepsResult
    }
    
    
    func calculateStepUnitsToBeAdded(_ stepUnits: Double, _ stepUnitsDual: Double) -> Double {
        var newStepUnits = stepUnits
        if goal.step.unit.isDual { newStepUnits += stepUnitsDual/goal.step.unit.dualRatio }
        
        return newStepUnits
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
