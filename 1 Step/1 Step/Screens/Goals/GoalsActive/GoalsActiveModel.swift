//
//  GoalsActiveModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

class GoalsActiveModel: ObservableObject {
    
    @Published var itemsAppear: [Bool] = Array(repeating: false, count: DataModel.shared.activeGoals.count+1)
    @Published var currentDragItem: Goal? = nil
    
    var itemsAppeared: Int { itemsAppear.reduce(0) { $0 + ($1 ? 1 : 0) } }
        
    
    //MARK: - Transition
    
    func initItemTransition(of sortOrder: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds((sortOrder+1-itemsAppeared)*130)) {
            self.itemsAppear[sortOrder] = true
        }
    }
        
    
    func itemsOpacityTransition(of goal: Goal) -> Double {
        return itemsAppear[Int(goal.sortOrder)] ? 1.0 : 0.0
    }
    
    
    func itemsScaleTransition(of goal: Goal) -> CGFloat {
        return itemsAppear[Int(goal.sortOrder)] ? 1.0 : 0.9
    }
    
    
    func createItemOpacityTransition() -> Double {
        return itemsAppear[itemsAppear.count-1] ? 1.0 : 0.0
    }
    
    
    //MARK: - UI
    
    let goalItemColumns = [
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth)),
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth))
    ]
    
    
    func itemsAnimation() -> Animation {
        return currentDragItem == nil ? .spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0) : .easeInOut(duration: 0.3)
    }
    
    
    //MARK: - Drag and Drop
    
    func onGoalDrag(_ goal: Goal) -> NSItemProvider {
        currentDragItem = goal
        return NSItemProvider(object: String(goal.sortOrder) as NSString)
    }
    
    
    struct DragRelocateDelegate: DropDelegate {
        
        @Binding var gridItems: [Goal]
        @Binding var current: Goal?
        
        let item: Goal
        
        func dropEntered(info: DropInfo) {
            if item != current {
                let from = gridItems.firstIndex(of: current!)!
                let to = gridItems.firstIndex(of: item)!
                
                if gridItems[to].sortOrder != current!.sortOrder {
                    updateSortOrder(from, to)
                }
            }
        }
        
        
        private func updateSortOrder(_ from: Int, _ to: Int) {
            let sortOrders = gridItems.map { $0.sortOrder }
            
            gridItems.move(fromOffsets: IndexSet(integer: from),
                toOffset: to > from ? to + 1 : to)
            
            zip(gridItems, sortOrders)
                .forEach { $0.sortOrder = $1 }
        }

        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }

        
        func performDrop(info: DropInfo) -> Bool {
            current = nil
            DataModel.shared.moveGoals()
            return true
        }
    }
}
