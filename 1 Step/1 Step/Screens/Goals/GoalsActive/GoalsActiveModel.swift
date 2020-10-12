//
//  GoalsActiveModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

class GoalsActiveModel: ObservableObject {
    
    @Published var currentDragItem: Goal? = nil
        
    
    let goalItemColumns = [
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth)),
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth))
    ]
    
    
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
            
            zip(gridItems, sortOrders).forEach { $0.sortOrder = $1 }
        }
        
        
        private func swapSortOrder(_ from: Int, _ to: Int) {
            let temp = gridItems[from].sortOrder
            gridItems[from].sortOrder = gridItems[to].sortOrder
            gridItems[to].sortOrder = temp
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
