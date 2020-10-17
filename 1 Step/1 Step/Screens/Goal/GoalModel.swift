//
//  GoalModel.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

final class GoalModel: TransitionObservableObject {
    
    enum DragState {
        case none
        case menu
        case complete
    }
    
    
    @Published var transition: TransitionManager<GoalModel> = TransitionManager()
    @Published var selectedGoal: Goal!
    
    @Published var dragState: DragState = .none
    @Published private var dragOffset: CGFloat = .zero
    
    
    //MARK: - Transition
    
    func initAppear() {
        dragState = .none
        transition.state = .fullHide
    }
    
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: DelayAfter.mountainAppear, fullHideAfter: .never)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    //MARK: - Global
    
    var goalDragOffset: CGFloat {
        switch dragState {
        case .none:     return dragOffset
        case .menu:     return menuWidth + dragOffset
        case .complete: return Layout.screenWidth
        }
    }
    
    var goalContentDragOffset: CGFloat {
        switch dragState {
        case .none:     return -dragOffset/2
        case .menu:     return -menuWidth/2 - dragOffset/2
        case .complete: return -Layout.screenWidth/2
        }
    }
    
    var headerButtonColor: Color {
        return changeThenStatic(standard: selectedGoal.color.get(), menu: .neutralToDarkNeutral)
    }
    
    
    func toggleMenuButton() {
        if dragState == .none { dragState = .menu } else { dragState = .none }
    }
    
    
    func menuButtonRotationDegree(_ degrees: Double) -> Angle {
        return changeThenStatic(standard: .zero, menu: .degrees(degrees))
    }
    
    func menuButtonRotationOffset(standard: CGFloat, menu: CGFloat) -> CGFloat {
        return changeThenStatic(standard: standard, menu: menu)
    }
    
    
    //MARK: - Summary
    
    var mountainTransitionOffset: CGFloat {
        return MountainLayout.offsetY + (!transition.isFullHidden ? 0 : MountainLayout.height)
    }
    
    var mountainAnimation: Animation {
        return transition.isFullAppeared ? .oneSAnimation() : .oneSMountainAnimation()
    }
    
    var mountainColor: Color {
        return changeThenStatic(standard: selectedGoal.color.get(), menu: .darkBackgroundToDarkGray)
    }
    
    var topTextColor: Color {
        return changeThenStatic(standard: .grayToBackground, menu: .neutralToDarkNeutral)
    }
    
    var stepUnitText: String {
        return selectedGoal.step.unit == .custom ? selectedGoal.step.customUnit : selectedGoal.step.unit.description
    }
    
    
    //MARK: - Menu
    
    let menuWidth: CGFloat = 160
    
    var menuDragOffset: CGFloat {
        switch dragState {
        case .none:     return -menuWidth + dragOffset
        case .menu:     return dragOffset
        case .complete: return -menuWidth + Layout.screenWidth
        }
    }
    
    
    //MARK: - Drag
    
    var viewDragOpacity: Double {
        if dragState == .complete { return 0.0 }
        
        //When reached - fully hidden
        let hidePoint = (Layout.screenWidth-menuWidth)/2
        
        //Fadeout: After MenuView to GoalsView
        let dragOpacity = 1 - Double(dragOffset / hidePoint)
        
        //Fadeout: Directly to GoalsView
        let dragDirectOpacity = 1 - Double((dragOffset-160) / hidePoint)
        
        return dragState == .menu ? dragOpacity : (dragOffset >= 160 ? dragDirectOpacity : 1.0)
    }
    
    
    private func changeThenStatic<T>(standard: T, menu: T) -> T {
        if onDrag(from: .menu) {
            return standard
        } else if dragState == .menu || onDrag(from: .none) {
            return menu
        }
        return standard
    }
    
    
    private func onDrag(from: DragState) -> Bool {
        return dragState == from && dragDirection(from)(dragOffset, 0)
    }
    
    
    private func dragDirection(_ from: DragState) -> (CGFloat, CGFloat) -> Bool {
        return from == .menu ? { $0 < $1 } : { $0 > $1 }
    }
    
    
    lazy private(set) var dragMenu = DragGesture()
        .onChanged { [weak self] value in self?.onChanged(value) }
        .onEnded { [weak self] value in self?.onEnded(value) }
    
    
    private func onChanged(_ value: DragGesture.Value) {
        if legalDrag(value) {
            dragOffset = value.translation.width
        }
    }
    
    
    private func onEnded(_ value: DragGesture.Value) {
        //If drag not legal - do nothing
        if !legalDrag(value) { return }
        
        //Forward drag
        if onToMenu(value) { toMenu() }
        else if onToGoalsFromMenu(value) { toGoals() }
        if onToGoals(value) { toGoals() }
        
        //Backward drag
        if onBackFromMenu(value) { backFromMenu() }
        
        dragOffset = .zero
    }
    
    //onChanged
    
    private func legalDrag(_ value: DragGesture.Value) -> Bool {
        return onDragBackward(value) || onDragForward(value)
    }
    
    
    private func onDragBackward(_ value: DragGesture.Value) -> Bool {
        return value.translation.width <= 0 && dragState == .menu
    }
    
    
    private func onDragForward(_ value: DragGesture.Value) -> Bool {
        return value.translation.width >= 0 && leadingEdgeDrag(value)
    }
    
    
    private func leadingEdgeDrag(_ value: DragGesture.Value) -> Bool {
        let screenEdge: CGFloat = Layout.screenWidth*0.15
        let screenEdgeMenu: CGFloat = 160 + screenEdge
        
        return value.startLocation.x <= (dragState == .menu ? screenEdgeMenu : screenEdge)
    }
    
    
    //onEnded
    
    private func onToMenu(_ value: DragGesture.Value) -> Bool {
        return value.translation.width >= 50 && dragState == .none
    }
    
    
    private func onToGoalsFromMenu(_ value: DragGesture.Value) -> Bool {
        return value.translation.width > 50 && dragState == .menu
    }
    
    
    private func onBackFromMenu(_ value: DragGesture.Value) -> Bool {
        return value.translation.width < -50 && dragState == .menu
    }
    
    
    private func onToGoals(_ value: DragGesture.Value) -> Bool {
        return value.translation.width >= 240*Layout.multiplierWidth
    }
    
    
    private func toMenu() { dragState = .menu }
    
    
    private func backFromMenu() { dragState = .none }
    
    
    private func toGoals() {
        dragState = .complete
        transition.state = .firstHide
        
        MainModel.shared.toScreen(.goals)
    }
}
