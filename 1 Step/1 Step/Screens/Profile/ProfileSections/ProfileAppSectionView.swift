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
                OneSDropDown(.long, title: "Settings", accessoryCustomSymbol: ProfileSymbol.settings, accessoryColor: UserColor.user0.get()) {
                    EmptyView()
                }
                
                OneSDropDown(.long, title: "Data & Privacy", accessorySFSymbol: ProfileSymbol.dataAndPrivacy, accessoryColor: UserColor.user0.get()) {
                    EmptyView()
                }
                
                OneSRowButton(.long, title: "Help", accessorySFSymbol: ProfileSymbol.help, accessoryColor: UserColor.user0.get()) {}
            }
        }
    }
}
