//
//  GoalSelectMountainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalSelectMountainView: View {
    
    @StateObject private var viewModel = GoalSelectMountainModel()
    
    
    var body: some View {
        let dragMountains = DragGesture()
            .onChanged { value in onChanged(value) }
            .onEnded { value in onEnded(value) }
        
        return ZStack {
            //Mountains
            HStack {
                ForEach(MountainImage.allCases, id: \.self) { mountain in
                    GoalSelectMountainItem(viewModel: viewModel, mountain: mountain)
                        .highPriorityGesture(dragMountains)
                }
                .frame(width: ScreenSize.width, height: MountainLayout.height)
            }
            .onPreferenceChange(GoalSelectMountainModel.MountainPK.self) { p in updatePreferences(p) }
            
            //Select Button
            
        }
        .coordinateSpace(name: CoordinateSpace.selectMountain.hashValue)
    }
    
    
    func updatePreferences(_ preferences: GoalSelectMountainModel.MountainPK.Value) {
        for p in preferences {
            viewModel.rects[Int(p.mountainID)] = p.rect
        }
    }
    
    
    func onChanged(_ value: DragGesture.Value) {
        if illegalDrag() { return }
        viewModel.dragOffset = value.translation
    }
    
    
    func onEnded(_ value: DragGesture.Value) {
        if illegalDrag() {
            viewModel.dragOffset = .zero
            return
        }
        changeMountain()
    }
    
    
    func changeMountain() {
        goToNextMountain()
        goToPrevMountain()
        viewModel.dragOffset = .zero
    }
    
    func goToNextMountain() {
        if viewModel.dragOffset.width < -50 { viewModel.currentMountain += 1 }
    }
    
    func goToPrevMountain() {
        if viewModel.dragOffset.width > 50 { viewModel.currentMountain -= 1 }
    }
    
    func illegalDrag() -> Bool {
        return illegalDragAtFirstMountain() || illegalDragAtLastMountain()
    }
    
    func illegalDragAtFirstMountain() -> Bool {
        return viewModel.currentMountain == 0 && viewModel.dragOffset.width > 0
    }
    
    func illegalDragAtLastMountain() -> Bool {
        return viewModel.currentMountain == CGFloat(MountainImage.allCases.count)-1
            && viewModel.dragOffset.width < 0
    }
}
