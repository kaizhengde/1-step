//
//  ProfileHelpView.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

struct ProfileHelpView: View {
    
    @StateObject private var sheetManager = SheetManager.shared
    @ObservedObject var profileModel: ProfileModel
    @StateObject private var viewModel = ProfileHelpModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView("Help", trailingButton: (.close, .grayToBackground, { sheetManager.dismiss() }))
                    
                    HStack {
                        OneSSecondaryHeaderText(text: "Frequently asked", color: profileModel.section1Color)
                        Spacer()
                    }
                    
                    HelpContentView(viewModel: viewModel)
                    
                    BottomView(profileModel: profileModel, viewModel: viewModel)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.top, 12)
                .padding(.bottom, 80*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct HelpContentView: View {
        
        @ObservedObject var viewModel: ProfileHelpModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<viewModel.rows.count) { i in
                    OneSDropDown(.shortBig, title: viewModel.rows[i].title) {
                        viewModel.rows[i].view
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
    private struct BottomView: View {
        
        @ObservedObject var profileModel: ProfileModel
        @ObservedObject var viewModel: ProfileHelpModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                OneSMultilineText(text: "You didn’t find the answer to your question or would like to make a suggestion? Feel free to contact me!")
                
                OneSRowButton(.shortBig, title: "Contact me", textColor: .backgroundToGray, backgroundColor: profileModel.section1Color) {}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
        }
    }
}
