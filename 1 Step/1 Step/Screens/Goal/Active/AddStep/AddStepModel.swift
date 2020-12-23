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
    @Published var pickerStopped: Bool = true
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    var addStepAnimationHandler = AddStepAnimationHandler.shared

    
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
    
    enum AddStepsResult: Equatable {
        
        case none
        case normal(forward: Bool)
        case milestoneChange(forward: Bool)
        case goalReached
        
        var isMilestoneChange: Bool {
            self == .milestoneChange(forward: true) || self == .milestoneChange(forward: false) || self == .goalReached
        }
        
        var isNormal: Bool { self == .normal(forward: true) || self == .normal(forward: false) }
    }
    
    
    func addButtonPressed() {
        if pickerStopped {
            OneSFeedback.light()
            dragState = .hidden
            
            let addStepsResult = addStepsAndCalculateResult()
            
            switch addStepsResult {
            case .goalReached:                              addStepAnimationHandler.startGoalReached()
            case let .milestoneChange(forward: forward):    addStepAnimationHandler.startMilestoneChange(forward: forward)
            case let .normal(forward: forward):             addStepAnimationHandler.startNormalAdd(forward: forward)
            case .none: return
            }
            
            if GoalModel.shared.showJourneyView {
                FirebaseAnalyticsEvent.GoalScreen.addStepsFromJourneyView()
            } else {
                FirebaseAnalyticsEvent.GoalScreen.addStepsFromSummaryView()
            }
        }
    }
    
    
    private func addStepsAndCalculateResult() -> AddStepsResult {
        
        //Calculate stepUnits to be added
        let newStepUnits = calculateStepUnitsToBeAdded()
        
        //Determine AddStepsResult
        let addStepsResult = getAddStepsResult(with: newStepUnits)
        
        //Save changed to CoreData
        if addStepsResult.isMilestoneChange {
            DispatchQueue.main.asyncAfter(deadline: .now() + addStepAnimationHandler.after(milestoneChangeState: .closeFinished)) {
                DataModel.shared.addSteps(self.goal, with: newStepUnits) { 
                    GoalModel.shared.objectWillChange.send()
                }
            }
        } else {
            DataModel.shared.addSteps(self.goal, with: newStepUnits) {
                GoalModel.shared.objectWillChange.send()
            }
        }
        
        return addStepsResult
    }
    
    
    private func calculateStepUnitsToBeAdded() -> Double {
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
        
        let newStepUnitsUnit = Double(stepAddArray.reversed()[selectedStepUnit])!
        let newStepUnitsDual = Double(stepAddArrayDual.reversed()[selectedStepDual])!
        
        var newStepUnits = newStepUnitsUnit
        
        if goal.step.unit.isDual {
            newStepUnits += newStepUnitsDual/goal.step.unit.dualRatio
        }
        
        return newStepUnits
    }
    
    
    private func getAddStepsResult(with newStepUnits: Double) -> AddStepsResult {
        let newCurrentStepUnits = GoalJourneyDataHandler.calculateNewCurrentStepUnits(with: goal, newStepUnits: newStepUnits)
        
        let currentMilestone = goal.milestones.filter { $0.state == .current }.first!
        let prevMilestoneNeededStepUnits = currentMilestone.neededStepUnits - currentMilestone.stepUnitsFromPrev
        
        //Goal Reached
        if Int16(newCurrentStepUnits) >= goal.neededStepUnits { return .goalReached }
        
        //Milestone Change
        if currentMilestone.neededStepUnits <= newCurrentStepUnits {
            return .milestoneChange(forward: true)
        } else if prevMilestoneNeededStepUnits > newCurrentStepUnits && goal.currentStepUnits > 0 {
            return .milestoneChange(forward: false)
        }
        
        //Steps
        return newStepUnits == 0 ? .none : (newStepUnits > 0 ? .normal(forward: true) : .normal(forward: false))
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
    
    
    //MARK: - Gesture
    
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
