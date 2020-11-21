//
//  ProfileAboutSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAboutSectionView: View {
    
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: "About") {
            EmptyView()
        }
    }
}
