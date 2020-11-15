//
//  MilestoneModel.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

class MilestoneModel: ObservableObject {
    
    var milestone: Milestone {
        GoalModel.shared.selectedGoal.milestones.filter { $0.state == .current }.first ?? Milestone(context: PersistenceManager.defaults.context)
    }
    var goal: Goal { milestone.parentGoal }
    
    init() { updateStepsMap() }
    
    
    @Published var stepsDic: [Int: Double] = [:]
    @Published var stepPositions: [Int: CGPoint] = [:]
    
    func updateStepsMap() {
        
        var dictionary: [Int: Double] = [:]
        
        let prevNeededSteps = Int(milestone.neededSteps-milestone.stepsFromPrev)
        
        var lowerBound = prevNeededSteps
        var upperBound = Int(milestone.neededSteps)
        
        if Int(goal.currentSteps) - prevNeededSteps > 3 {
            lowerBound = Int(goal.currentSteps)-3
        }
        
        if milestone.neededSteps - goal.currentSteps > 12 {
            upperBound = Int(goal.currentSteps)+12
        }
        
        for i in lowerBound..<upperBound {
            dictionary[i] = Double(i)/Double(goal.step.unitRatio)
        }
        
        stepsDic = dictionary
    }

    
    var showLongMark: Bool { milestone.neededSteps - goal.currentSteps > 20 }
    
    //MARK: - Layout
    
    var lineHeight: CGFloat {
        abs((stepPositions[Int(goal.currentSteps)]?.y ?? 0) - (stepPositions[-1]?.y ?? 0))
    }
    
    
    
    //MARK: - Step Preferences
    
    func updateStepPositions(_ preferences: StepPK.Value) {
        for p in preferences {
            stepPositions[p.steps] = p.position
        }
    }


    struct StepVS: View {

        let steps: Int


        var body: some View {
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: StepPK.self, value: [StepPD(steps: steps, position: proxy.frame(in: .milestoneView).origin)])
            }
        }
    }


    struct StepPK: PreferenceKey {

        typealias Value = [StepPD]

        static var defaultValue: [StepPD] = []


        static func reduce(value: inout [StepPD], nextValue: () -> [StepPD]) {
            value.append(contentsOf: nextValue())
        }
    }


    struct StepPD: Equatable {

        var steps: Int
        var position: CGPoint
    }
    
    
    //MARK: - Milestone Item
    
    struct MilestoneItemModifier: ViewModifier {
        
        var milestone: Milestone
        var goal: Goal { milestone.parentGoal }
        
        
        func body(content: Content) -> some View {
            content
                .background(goal.color.get(milestone.state == .active ? .dark : .light))
                .cornerRadius(8)
                .contentShape(Rectangle())
                .oneSShadow(opacity: 0.15, y: 3, blur: 10)
                .overlay(
                    Group {
                        if milestone.state == .done {
                            VStack {
                                HStack {
                                    Spacer()
                                    SFSymbol.checkmark
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(goal.color.get(.dark))
                                        .padding(20)
                                }
                                Spacer()
                            }
                        }
                    }
                )
        }
    }
}


extension VerticalAlignment {
    
    enum MilestoneBottomAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.top]
        }
    }
    
    static let milestoneBottomAlignment = Self(MilestoneBottomAlignment.self)
}

