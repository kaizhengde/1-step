//
//  ProfileScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ProfileHeaderView()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
        }
    }
}
