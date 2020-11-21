//
//  ProfileScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var profileModel = ProfileModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    ProfileHeaderView()
                        .padding(.bottom, -12)
                    
                    ProfileAccomplishmentsSectionView(profileModel: profileModel)
                    Group {
                        ProfileAppSectionView(profileModel: profileModel)
                        ProfileAboutSectionView(profileModel: profileModel)
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .offset(y: -32)
                }
                .padding(.bottom, 300*Layout.multiplierHeight)
            }
        }
    }
}
