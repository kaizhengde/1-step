//
//  GoalsScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsScreen: View {
    
    var body: some View {
        ZStack {
            Color.whiteToDarkGray
            
            ScrollView {
                VStack {
                    GoalsHeaderView()
                    GoalsContentView()
                }
                .padding(.horizontal, Layout.firstLayerPadding)
            }
        }
    }
}
