//
//  GoalsGridModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI
import UniformTypeIdentifiers
import Firebase

class GoalsGridModel: ObservableObject {
    
    var tab: GoalsTab
    var goals: [Goal] { tab.isActive ? DataModel.shared.activeGoals : DataModel.shared.reachedGoals }
    
    @Published var itemsAppear: [Bool] = []
    @Published var currentDragItem: Goal? = nil
    
    var itemsAppeared: Int { itemsAppear.reduce(0) { $0 + ($1 ? 1 : 0) } }
    
    
    init(tab: GoalsTab) {
        self.tab = tab
        updateItemsAppear()
    }
    
    func updateItemsAppear() {
        itemsAppear = Array(repeating: false, count: goals.count+1)
    }
        
    
    //MARK: - Transition
        
    func resetTransition() {
        updateItemsAppear()
    }
    
    
    func initItemTransition(of sortOrder: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds((sortOrder+1-itemsAppeared)*120)) {
            self.itemsAppear[sortOrder-1] = true
        }
    }
    
    
    func itemsTransition(of goal: Goal) -> Binding<Bool> {
        return Binding<Bool>(get: { self.itemsAppear[Int(goal.sortOrder)-1] }, set: { _ in })
    }
    
    
    func createItemTransition() -> Binding<Bool> {
        return Binding<Bool>(get: { self.itemsAppear[self.itemsAppear.count-1]}, set: { _ in })
    }
    
    
    //MARK: - UI
    
    let goalItemColumns = [
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth)),
        GridItem(.fixed(GoalItemArt.width+14*Layout.multiplierWidth))
    ]
    
    
    func itemsAnimation() -> Animation {
        return currentDragItem == nil ? .oneSMountainAnimation(response: 0.4, dampingFraction: 0.5) : .oneSAnimation()
    }
    
    
    //MARK: - Actions
    
    func itemTapped(of goal: Goal) {
        if tab.isActive {
            GoalModel.shared.selectedGoal = goal
            MainModel.shared.toGoalScreen(.active)
        } else {
            GoalReachedModel.shared.selectedGoal = goal
            MainModel.shared.toGoalScreen(.reached)
        }
    }
    
    
    //MARK: - Drag and Drop
    
    func onGoalDrag(_ goal: Goal) -> NSItemProvider {
        OneSFeedback.heavy()
        currentDragItem = goal
        return NSItemProvider(object: String(goal.sortOrder) as NSString)
    }
    
    
    var dropType = [UTType.text]
    
    
    struct DragAndDropDelegate: DropDelegate {
        
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
            OneSFeedback.soft()
            
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
            
            DataModel.shared.moveGoals(in: item.currentState) {}
            return true
        }
    }
}
