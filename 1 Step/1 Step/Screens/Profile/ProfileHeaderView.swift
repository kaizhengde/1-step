//
//  ProfileHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        OneSHeaderView("Profile", trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) })) {
            AnyView(
                VStack {
                    ProfileImageView()
                    ProfileNameView()
                }
            )
        }
    }
    
    
    private struct ProfileImageView: View {
        
        var body: some View {
            Circle()
                .frame(width: 150*Layout.multiplierWidth, height: 150*Layout.multiplierWidth)
                .foregroundColor(.darkBackgroundToDarkGray)
                .oneSShadow(opacity: 0.15, y: 2, blur: 8)
                .overlay(
                    SFSymbol.camera
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(.neutralToDarkNeutral)
                )
        }
    }
    
    
    private struct ProfileNameView: View {
        
        var body: some View {
            OneSText(text: "Kai", font: .custom(weight: Raleway.medium, size: 28), color: .grayToBackground)
        }
    }
}
