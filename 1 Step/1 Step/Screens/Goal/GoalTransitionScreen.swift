//
//  GoalTransitionScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

struct GoalTransitionScreen: View {
    
    @State private var appear = false
    
    
    var body: some View {
        Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            .oneSShadow(opacity: 0.2, y: 0, blur: 13)
            .offset(x: appear ? 0 : Layout.screenWidth)
            .onAppear { appear = true }
            .oneSAnimation()
    }
}
