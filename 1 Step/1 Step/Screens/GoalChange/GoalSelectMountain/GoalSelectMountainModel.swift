//
//  GoalSelectMountainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

typealias GoalSelectMountainData = (mountain: MountainImage, color: UserColor)

class GoalSelectMountainModel: ObservableObject {
    
    @Published private var transition = ViewTransition<GoalSelectMountainModel>(finishDelay: .now() + AnimationDuration.mountainAppear)

    @Published private var currentMountain: CGFloat = .zero
    @Published private var dragOffset: CGSize = .zero
    @Published private var rects: [CGRect] = Array<CGRect>(repeating: .zero, count: MountainImage.allCases.count)

    @Published private var selectedData: GoalSelectMountainData = (.mountain0, .user0)
    
    
    func initTransition() {
        transition.delegate = self
        transition.state = .appear
    }
    
    func transitionDelay() -> Double {
        return transition.didFinish ? 0.0 : AnimationDuration.mountainAppear
    }
    
    
    //MARK: - MountainItem
    
    func mountainItemScale(_ mountain: MountainImage) -> CGFloat {
        return CGFloat(mountain.rawValue) == currentMountain ? 1.0 : 0.9
    }
    
    
    func mountainItemRotationAngle(_ mountain: MountainImage) -> Angle {
        return Angle(degrees: Double(rects[Int(mountain.rawValue)].minX) / 7)
    }
    
    
    func mountainItemOffsetX() -> CGFloat {
        return dragOffset.width - ScreenSize.width*currentMountain
    }
    
    
    //Text
    
    func textOpacity(_ mountain: MountainImage) -> Double {
        return (transition.didFinish && currentMountain == CGFloat(mountain.rawValue) && dragOffset.width == 0) ? 1.0 : 0.0
    }
    
    
    //Mountain
    
    func transistionOffset() -> CGFloat {
        return transition.didAppear ? 0 : ScreenSize.height/1.3
    }
    
    
    func mountainColor(_ mountain: MountainImage) -> Color {
        return CGFloat(mountain.rawValue) == currentMountain ? selectedData.color.get() : .darkBackgroundToBlack
    }
    
    
    func newMountainColor() {
        let colorID = selectedData.color.rawValue
        
        //Next color if there is one, else go back to the first one
        self.selectedData.color = UserColor(rawValue: colorID+1) ?? UserColor(rawValue: 0)!
    }
    
    
    //MARK: - DragGesture
    
    lazy private(set) var dragMountains = DragGesture()
        .onChanged { value in self.onChanged(value) }
        .onEnded { value in self.onEnded(value) }
    
    
    private func onChanged(_ value: DragGesture.Value) {
        if illegalDrag() { return }
        dragOffset = value.translation
    }
    
    
    private func onEnded(_ value: DragGesture.Value) {
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
        if dragOffset.width < -50 { currentMountain += 1 }
    }
    
    
    private func goToPrevMountain() {
        if dragOffset.width > 50 { currentMountain -= 1 }
    }
    
    
    private func illegalDrag() -> Bool {
        return illegalDragAtFirstMountain() || illegalDragAtLastMountain()
    }
    
    
    private func illegalDragAtFirstMountain() -> Bool {
        return currentMountain == 0 && dragOffset.width > 0
    }
    
    
    private func illegalDragAtLastMountain() -> Bool {
        return currentMountain == CGFloat(MountainImage.allCases.count)-1
            && dragOffset.width < 0
    }
    
    
    //MARK: - Mountain Preference Key
    
    func updatePreferences(_ preferences: GoalSelectMountainModel.MountainPK.Value) {
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



