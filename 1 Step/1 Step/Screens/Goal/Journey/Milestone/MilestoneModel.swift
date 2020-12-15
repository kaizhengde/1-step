//
//  MilestoneModel.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI
import Combine

class MilestoneModel: ObservableObject {
    
    var milestone: Milestone {
        GoalModel.shared.selectedGoal.milestones.filter { $0.state == .current }.first ?? Milestone(context: PersistenceManager.defaults.context)
    }
    
    var goal: Goal { milestone.parentGoal }
    
    init() { updateMarkViewsAmount() }
    
    static let progressCircleTapped = PassthroughSubject<Void, Never>()
    
    
    //MARK: - Layout
    
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
        case 61...100:      amount = 5
        case 101...140:     amount = 6
        case 141...180:     amount = 7
        case 181...220:     amount = 8
        case 221...260:     amount = 9
        case 261...300:     amount = 10
        case 301...340:     amount = 11
        case 341...400:     amount = 12
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
        case 20...39:       height = 140
        case 40...59:       height = 170
        case 60...79:       height = 200
        case 80...99:       height = 230
        case 100...119:     height = 260
        case 120...139:     height = 290
        case 140...159:     height = 320
        case 160...179:     height = 350
        case 180...199:     height = 380
        case 200...219:     height = 410
        case 220...239:     height = 440
        case 240...259:     height = 470
        case 260...279:     height = 500
        case 280...299:     height = 530
        case 300...319:     height = 560
        case 320...339:     height = 590
        case 340...359:     height = 620
        case 360...379:     height = 650
        case 380...400:     height = 680
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
                .background(milestone.state == .active ? goal.color.dark : goal.color.light)
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
                                        .foregroundColor(goal.color.dark)
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

