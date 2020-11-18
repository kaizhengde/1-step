//
//  MilestoneModel.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

final class MilestoneModel: ObservableObject {
    
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
        case 1...2:         height = 50
        case 3...10:        height = 80
        case 10...19:       height = 110
        case 20...29:       height = 140
        case 30...39:       height = 170
        case 40...49:       height = 200
        case 50...59:       height = 230
        case 60...69:       height = 260
        case 70...79:       height = 290
        case 80...89:       height = 320
        case 90...99:       height = 350
        case 100...109:     height = 380
        case 110...119:     height = 410
        case 120...129:     height = 440
        case 130...139:     height = 470
        case 140...149:     height = 500
        case 150...159:     height = 530
        case 160...169:     height = 560
        case 170...179:     height = 590
        case 180...189:     height = 620
        case 190...200:     height = 650
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

