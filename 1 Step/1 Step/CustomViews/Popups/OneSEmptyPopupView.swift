//
//  OneSPopupEmptyView.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSEmptyPopupView: View {
    
    @StateObject private var popupManager = PopupManager.shared
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
        .frame(width: 260*ScreenSize.multiplierWidth, height: 340*ScreenSize.multiplierHeight)
        .foregroundColor(popupManager.viewBackgroundColor)
        .onAppear { print("Empty Appear") }
        .onDisappear { print("Empty Disappear") }
    }
}
