//
//  GoalModel.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI
import Combine

final class GoalModel: TransitionObservableObject {
    
    enum DragState {
        case none
        case menu
        case complete
    }
    
    enum ScrollPosition: Int {
        case none       = -1
        case top        = 0
        case current    = 1
    }
    
    @Published var transition = TransitionManager<GoalModel>()
    @Published var selectedGoal: Goal!
    
    @Published var dragState: DragState = .none
    @Published var dragOffset: CGFloat = .zero
    
    @Published var scrollOffset: CGFloat = .zero
    let didSetScrollPosition = PassthroughSubject<ScrollPosition, Never>()
    
    @Published var showJourneyView: Bool = false
    
    
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
    
    var viewDragOpacity: Double { dragProgressToHide }
    
  
    func viewDragColor(standard: Color, menu: Color) -> Color {
        return standard.interpolateTo(color: menu, fraction: dragProgressToMenu)
    }
    
    
    var headerButtonColor: Color {
        return viewDragColor(standard: selectedGoal.color.get(), menu: .neutralToDarkNeutral)
    }
    
    
    func toggleMenuButton() {
        if dragState == .none { dragState = .menu } else { dragState = .none }
    }
    
    
    func menuButtonRotationDegree(_ degrees: Double) -> Angle {
        let angle = 0 + (degrees - 0) * dragProgressToMenu
        return .degrees(angle)
    }
    
    
    func menuButtonRotationOffset(standard: CGFloat, menu: CGFloat) -> CGFloat {
        return standard + (menu - standard) * CGFloat(dragProgressToMenu)
    }
    
    
    //MARK: - Summary
    
    var mountainTransitionOffset: CGFloat {
        return MountainLayout.offsetY + (!transition.isFullHidden ? 0 : MountainLayout.height)
    }
    
    var mountainAnimation: Animation {
        return transition.isFullAppeared ? .oneSAnimation() : .oneSMountainAnimation()
    }
    
    var backgroundColor: Color {
        return viewDragColor(standard: selectedGoal.color.get(), menu: .darkBackgroundToDarkGray)
    }
    
    var topTextColor: Color {
        return viewDragColor(standard: .grayToBackground, menu: .neutralToDarkNeutral)
    }
    
    var goalUnitText: String {
        return selectedGoal.step.unit == .custom ? selectedGoal.step.customUnit : selectedGoal.step.unit.description
    }
    
    var showDownArrow: Bool { return noDrag ? true : false }
    
    
    //MARK: - Menu
    
    let menuWidth: CGFloat = 160
    
    var menuDragOffset: CGFloat {
        switch dragState {
        case .none:     return -menuWidth + dragOffset
        case .menu:     return dragOffset
        case .complete: return -menuWidth + Layout.screenWidth
        }
    }
    
    
    //MARK: - Journey
    
    var journeyViewDragOpacity: Double { return 1-dragProgressToMenu }
    
    
    //MARK: - Drag
        
    var noDrag: Bool {
        return transition.isFullAppeared && dragState == .none && dragOffset == 0
    }
    
    private let hidePoint: CGFloat = (Layout.screenWidth-160)/2
    
    private var dragProgressToHide: Double {
        if dragState == .menu {
            return 1 - Double(dragOffset / hidePoint)
        } else if dragOffset >= menuWidth {
            return 1 - Double((dragOffset-menuWidth) / hidePoint)
        }
        return dragState == .complete ? 0.0 : 1.0
    }
    
    private var dragProgressToMenu: Double {
        if dragOffset <= menuWidth {
            return dragState == .menu ? min(1+Double(dragOffset/menuWidth), 1) : Double(dragOffset/menuWidth)
        }
        return 1
    }
    
    
    //Gesture
    
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
        didSetScrollPosition.send(.top)
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
    
    
    //MARK: - Scroll
    
    //Scroll Proxy
    
    func downArrowTapped() {
        if showJourneyView {
            didSetScrollPosition.send(.top)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.showJourneyView = false }
        } else {
            showJourneyView = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { self.didSetScrollPosition.send(.current) }
        }
    }
    
    
    //Preference
    
    func updatePreferences(_ value: ScrollPK.Value) {
        scrollOffset = value
        if value >= 30 {
            showJourneyView = true
        } else if value <= -27 {
            showJourneyView = false
        }
    }
    
    
    struct ScrollVS: View {
        
        var body: some View {
            GeometryReader {
                Color.clear.preference(key: ScrollPK.self, value: -$0.frame(in: .goalScroll).origin.y+20)
            }
        }
    }
    
    
    struct ScrollPK: PreferenceKey {
        
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
}
