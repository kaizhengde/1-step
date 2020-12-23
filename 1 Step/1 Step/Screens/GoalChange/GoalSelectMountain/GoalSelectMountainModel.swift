//
//  GoalSelectMountainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

fileprivate extension MountainImage {
    
    mutating func nextMountain() {
        self = Self(rawValue: self.rawValue+1)!
    }
    
    
    mutating func prevMountain() {
        self = Self(rawValue: self.rawValue-1)!
    }
    
    
    func isFirst() -> Bool { return self.rawValue == 0 }
    func isLast() -> Bool { return self.rawValue == Self.allCases.count-1 }
}


typealias GoalSelectMountainData = (mountain: MountainImage?, color: UserColor)

protocol GoalSelectMountainDelegate: AnyObject {
    
    //Somewhere to put the selectedMountainData
    var selectedMountainData: GoalSelectMountainData { get set }
    
    //Code to really dismiss goalSelectMountainView + additionals
    func dismissGoalSelectMountainView()
}


final class GoalSelectMountainModel: TransitionObservableObject {
    
    @Published var transition: TransitionManager<GoalSelectMountainModel> = TransitionManager()

    @Published var currentMountain: MountainImage = .mountain0
    @Published var dragOffset: CGFloat = .zero
    @Published private var rects: [CGRect] = Array<CGRect>(repeating: .zero, count: MountainImage.allCases.count)

    @Published var selectedData: GoalSelectMountainData = (nil, .user0) {
        didSet { delegate?.selectedMountainData = selectedData }
    }
    
    weak var delegate: GoalSelectMountainDelegate?
    
    //MARK: - Transition
    //fullHide:    Mountain hide
    //firstAppear: Mountain appear
    //fullAppear:  Text and selectButton appear
    //firstHide:   Text and selectButton hide
    
        
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: Animation.Delay.mountainAppear, fullHideAfter: Animation.Delay.opacity)
        transition.delegate = self
        
        transition.state = .firstAppear
    }
    
    
    func transitionDidFullHide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.mountainDismiss) { self.delegate?.dismissGoalSelectMountainView() }
    }
    
    
    //MARK: - First Create
    
    func considerFirstSelectMountain() {
        if UserDefaultsManager.shared.firstSelectMountain {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                OneSTutorialGIF.showPopup(for: .firstSelectMountain)
            }
        }
    }
    
    var onFirstSelectColor = false
    
    func considerFirstSelectColor() {
        if UserDefaultsManager.shared.firstSelectColor && !onFirstSelectColor {
            onFirstSelectColor = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                OneSTutorialGIF.showPopup(for: .firstSelectColor)
            }
        }
    }
    
    
    let firstDismissListener = PopupManager.shared.dismissed.sink {
        if $0 == .firstSelectMountain {
            UserDefaultsManager.shared.firstSelectMountain = false
        } else if $0 == .firstSelectColor {
            UserDefaultsManager.shared.firstSelectColor = false
        }
    }
    
    
    //MARK: - MountainItem
    
    func mountainItemScale(_ mountain: MountainImage) -> CGFloat {
        return mountain == currentMountain ? 1.0 : 0.9
    }
    
    
    func mountainItemRotationAngle(_ mountain: MountainImage) -> Angle {
        return Angle(degrees: Double(rects[Int(mountain.rawValue)].minX) / 7)
    }
    
    
    func mountainItemOffsetX() -> CGFloat {
        return dragOffset - Layout.screenWidth*CGFloat(currentMountain.rawValue)
    }
    
    
    //Text
    
    func textAndButtonOpacity(_ mountain: MountainImage) -> Double {
        return (transition.isFullAppeared && currentMountain == mountain && dragOffset == 0) ? 1.0 : 0.0
    }
    
    
    //Mountain
    
    func mountainTransistionOffset() -> CGFloat {
        return MountainLayout.offsetYNoScrollView + (!transition.isFullHidden ? 0 : MountainLayout.height)
    }
    
    
    func mountainColor(_ mountain: MountainImage) -> Color {
        return mountain == currentMountain ? selectedData.color.standard : .darkBackgroundToBlack
    }
    
    
    func selectMountainColor() {
        let colorID = selectedData.color.rawValue
        
        //Next color if there is one, else go back to the first one
        self.selectedData.color = UserColor(rawValue: colorID+1) ?? UserColor(rawValue: 0)!
    }
    
    
    //SelectButton
    
    func selectMountainAndDismiss() {
        selectedData.mountain = currentMountain
        
        if delegate is GoalCreateModel {
            transition.state = .firstHide
        }

        delegate?.selectedMountainData = selectedData
    }
    
    
    func selectButtonText(_ mountain: MountainImage) -> String {
        return selectedData.mountain == mountain ? Localized.current : Localized.select
    }
    
    
    func selectButtonColor(_ mountain: MountainImage) -> Color {
        return selectedData.mountain == mountain ? .grayToBackground : .backgroundToGray
    }
    
    
    //MARK: - DragGesture
    
    func updating(_ value: DragGesture.Value, _ state: inout CGFloat, _ transaction: Transaction) {
        if illegalDrag() { return }
        state = value.translation.width
    }
    
    
    func onEnded(_ value: DragGesture.Value) {
        if illegalDrag() {
            dragOffset = .zero
            return
        }
        changeMountain()
    }
    
    
    private func changeMountain() {
        goToNextMountain()
        goToPrevMountain()
        dragOffset = .zero
    }
    
    
    private func goToNextMountain() {
        if dragOffset < -50 { currentMountain.nextMountain() }
    }
    
    
    private func goToPrevMountain() {
        if dragOffset > 50 { currentMountain.prevMountain() }
    }
    
    
    private func illegalDrag() -> Bool {
        return illegalDragAtFirstMountain() || illegalDragAtLastMountain()
    }
    
    
    private func illegalDragAtFirstMountain() -> Bool {
        return currentMountain.isFirst() && dragOffset > 0
    }
    
    
    private func illegalDragAtLastMountain() -> Bool {
        return currentMountain.isLast() && dragOffset < 0
    }
    
    
    //MARK: - Mountain Preference Key
    
    func updatePreferences(_ preferences: MountainPK.Value) {
        for p in preferences {
            rects[Int(p.mountainID)] = p.rect
        }
    }
    
    
    struct MountainVS: View {
        let mountainID: MountainImage.RawValue
        
        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: MountainPK.self, value: [MountainPD(mountainID: self.mountainID, rect: geometry.frame(in: .selectMountain))])
            }
        }
    }
    

    struct MountainPK: PreferenceKey {
        typealias Value = [MountainPD]
        
        static var defaultValue: [MountainPD] = []
        
        static func reduce(value: inout [MountainPD], nextValue: () -> [MountainPD]) {
            value.append(contentsOf: nextValue())
        }
    }
    

    struct MountainPD: Equatable {
        var mountainID: MountainImage.RawValue
        var rect: CGRect
    }
}



