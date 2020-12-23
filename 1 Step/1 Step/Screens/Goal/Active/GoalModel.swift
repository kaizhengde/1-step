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
    
    static let shared = GoalModel()
    private init() {}
    
    
    @Published var transition = TransitionManager<GoalModel>()
    @Published var selectedGoal: Goal!
    
    @Published var dragState: DragState = .none
    @Published var dragOffset: CGFloat = .zero
    
    @Published var scrollOffset: CGFloat = .zero
    let setScrollPosition = PassthroughSubject<ScrollPosition, Never>()
    
    @Published var showJourneyView: Bool = false
    var onScrollToJourneyView = false
    @Published var journeyViewDisappeared = true
    @Published var showFlag: Bool = false
    
    @Published var appAppearance: ColorScheme = .light
    
    
    func appear(with appearance: ColorScheme) {
        initTransition()
        appAppearance = appearance
        considerFirstOpenGoal()
    }
    
    
    //MARK: - Transition
    
    func initAppear() {
        dragState = .none
        transition.state = .fullHide
    }
    
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: Animation.Delay.mountainAppear, fullHideAfter: .never)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    //MARK: - First Open
    
    func considerFirstOpenGoal() {
        if UserDefaultsManager.shared.firstOpenGoal {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                OneSTutorialGIF.showPopup(for: .firstOpenGoal)
            }
        }
    }
    
    
    let firstDismissListener = PopupManager.shared.dismissed.sink {
        if $0 == .firstOpenGoal {
            UserDefaultsManager.shared.firstOpenGoal = false
        }
    }
    
    
    //MARK: - Global
    
    func updateAppearance(with newAppearance: ColorScheme) {
        if UserDefaultsManager.shared.settingAppearance == .mirrorDevice {
            appAppearance = newAppearance
        }
    }
    
    
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
        var menuColor: Color!
        
        switch appAppearance {
        case .light:        menuColor = .darkNeutralStatic
        case .dark:         menuColor = .neutralStatic
        @unknown default:   menuColor = .white
        }
        
        return viewDragColor(standard: selectedGoal.color.standard, menu: menuColor)
    }
    
    
    func toggleMenuButton() {
        if dragState == .none {
            FirebaseAnalyticsEvent.GoalScreen.buttonToMenu()
            FirebaseAnalyticsEvent.GoalScreen.toMenu()
            toMenu()
        } else {
            FirebaseAnalyticsEvent.GoalScreen.buttonToGoals()
            FirebaseAnalyticsEvent.GoalScreen.toGoals()
            toGoals()
        }
    }
    
    
    func menuButtonRotationDegree(_ degrees: Double) -> Angle {
        let angle = 0 + (degrees - 0) * dragProgressToMenu
        return .degrees(angle)
    }
    
    
    func menuButtonRotationOffset(standard: CGFloat, menu: CGFloat) -> CGFloat {
        return standard + (menu - standard) * CGFloat(dragProgressToMenu)
    }
    
    
    func onDismissGoalCompletePopup() {
        if selectedGoal.currentState == .reached {
            MainModel.shared.toScreen(.goals)
            DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.opacity) { self.showFlag = false }
        }
    }
    
    
    //MARK: - Summary
    
    var mountainTransitionOffset: CGFloat {
        return MountainLayout.offsetY + (!transition.isFullHidden ? 0 : MountainLayout.height)
    }
    
    var mountainAnimation: Animation {
        return transition.isFullAppeared ? .oneSAnimation() : .oneSMountainAnimation()
    }
    
    var backgroundColor: Color {
        var menuColor: Color!
        
        switch appAppearance {
        case .light:        menuColor = .darkBackgroundStatic
        case .dark:         menuColor = .darkGrayStatic
        @unknown default:   menuColor = .white
        }
                
        return viewDragColor(standard: selectedGoal.color.standard, menu: menuColor)
    }
    
    var topTextColor: Color {
        var standardColor: Color!
        var menuColor: Color!
        
        switch appAppearance {
        case .light:        standardColor = .grayStatic
        case .dark:         standardColor = .backgroundStatic
        @unknown default:   standardColor = .white
        }
        
        switch appAppearance {
        case .light:        menuColor = .darkNeutralStatic
        case .dark:         menuColor = .neutralStatic
        @unknown default:   menuColor = .white
        }
                
        return viewDragColor(standard: standardColor, menu: menuColor)
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
    
    func updating(_ value: DragGesture.Value, _ state: inout CGFloat, _ transaction: Transaction) {
        if legalDrag(value) {
            if noDrag { OneSFeedback.soft() }
            state = value.translation.width
        }
    }
    
    
    func onEnded(_ value: DragGesture.Value) {
        //If drag not legal - do nothing
        if !legalDrag(value) { return }
        
        //Forward drag
        if onToGoals(value) {
            FirebaseAnalyticsEvent.GoalScreen.dragToGoalsDirectly()
            FirebaseAnalyticsEvent.GoalScreen.toGoals()
            toGoals()
        }
        else if onToMenu(value) {
            FirebaseAnalyticsEvent.GoalScreen.dragToMenu()
            FirebaseAnalyticsEvent.GoalScreen.toMenu()
            toMenu()
        }
        else if onToGoalsFromMenu(value) {
            FirebaseAnalyticsEvent.GoalScreen.dragToGoalsFromMenu()
            FirebaseAnalyticsEvent.GoalScreen.toGoals()
            toGoals()
        }
        
        //Backward drag
        if onBackFromMenu(value) { backFromMenu() }
        
        dragOffset = .zero
    }
    
    //onChanged
    
    private func legalDrag(_ value: DragGesture.Value) -> Bool {
        return (onDragBackward(value) || onDragForward(value)) && transition.isFullAppeared
    }
    
    
    private func onDragBackward(_ value: DragGesture.Value) -> Bool {
        return value.translation.width <= 0 && dragState == .menu
    }
    
    
    private func onDragForward(_ value: DragGesture.Value) -> Bool {
        if !journeyViewDisappeared && dragState == .menu { return false }
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
    
    
    private func toMenu() {
        setScrollPosition.send(.top)
        showJourneyView = false
        
        dragState = .menu
    }
    
    
    private func backFromMenu() {
        dragState = .none
    }
    
    
    private func toGoals() {
        dragState = .complete
        transition.state = .firstHide
        
        MainModel.shared.toScreen(.goals)
    }
    
    
    //MARK: - Scroll
    
    //Scroll Proxy
    
    func downArrowTapped() {
        if showJourneyView {
            setScrollPosition.send(.top)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.showJourneyView = false }
        } else {
            onScrollToJourneyView = true
            showJourneyView = true
            FirebaseAnalyticsEvent.GoalScreen.downArrowToJourneyView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.setScrollPosition.send(.current)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.onScrollToJourneyView = false }
            }
        }
    }
    
    
    //Preference
    
    func updatePreferences(_ value: ScrollPK.Value) {
        scrollOffset = value
        if value >= 30 {
            if !showJourneyView && !onScrollToJourneyView {
                FirebaseAnalyticsEvent.GoalScreen.scrollToJourneyView()
            }
            showJourneyView = true
        } else {
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


extension HorizontalAlignment {
    
    enum FlagMountainAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    
    
    static let flagMountainAlignment = Self(FlagMountainAlignment.self)
}
