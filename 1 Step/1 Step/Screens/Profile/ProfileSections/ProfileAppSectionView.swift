//
//  ProfileAppSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAppSectionView: View {
    
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: "App") {
            VStack(spacing: 20) {
                OneSDropDown(.long, title: "Settings") { EmptyView() }
                OneSDropDown(.long, title: "Data & Privacy") { EmptyView() }
                OneSDropDown(.long, title: "Help") { EmptyView() }
            }
        }
    }
}
