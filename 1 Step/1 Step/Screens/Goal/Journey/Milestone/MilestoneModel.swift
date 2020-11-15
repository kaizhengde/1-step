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
    
    init() { updateMarkViewsAmount() }
    
    
    //MARK: - layout
    
    @Published var markViewsAmount: Int = 0
    
    
    func updateMarkViewsAmount() {
        var amount = 0
        
        let currentSteps = Int(goal.currentSteps)
        let stepsNeeded = Int(milestone.neededSteps)
        
        switch stepsNeeded-currentSteps {
        case 0...2:         amount = 0
        case 3...10:        amount = 1
        case 11...20:       amount = 2
        case 21...40:       amount = 3
        case 41...60:       amount = 4
        case 61...80:       amount = 5
        case 81...100:      amount = 6
        case 101...120:     amount = 7
        case 121...140:     amount = 8
        case 141...160:     amount = 9
        case 161...180:     amount = 10
        case 181...200:     amount = 11
        default: break
        }
        
        markViewsAmount = amount
    }
    
    
    var lineHeight: CGFloat {
        var height: CGFloat = .zero
        
        let currentSteps = Int(goal.currentSteps)
        let prevStepsNeeded = Int(milestone.neededSteps - milestone.stepsFromPrev)
        
        switch currentSteps-prevStepsNeeded {
        case 0:             height = 0
        case 1...3:         height = 50
        case 4...10:        height = 80
        case 11...20:       height = 120
        case 21...50:       height = 170
        case 51...100:      height = 230
        case 101...150:     height = 300
        case 151...200:     height = 380
        default: break
        }
        
        return height
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
    
    enum CircleLineAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.top]
        }
    }
    
    
    static let circleLineAlignment = Self(CircleLineAlignment.self)
}

