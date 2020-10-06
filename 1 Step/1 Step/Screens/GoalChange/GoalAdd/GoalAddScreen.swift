//
//  GoalsAddScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalAddScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        ZStack {
            VStack {
                OneSHeaderView(trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) }))
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
        }
    }
}
