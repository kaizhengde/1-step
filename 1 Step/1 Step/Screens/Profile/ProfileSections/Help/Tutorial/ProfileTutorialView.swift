//
//  ProfileTutorialView.swift
//  1 Step
//
//  Created by Kai Zheng on 14.12.20.
//

import SwiftUI

struct ProfileTutorialView: View {
    
    @StateObject private var viewModel = ProfileTutorialModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView(Localized.tutorial, trailingButton: (.close, .grayToBackground, { SheetManager.shared.dismiss() }), isInsideSheet: true)
                    
                    TutorialContentView(viewModel: viewModel)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.bottom, 100*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct TutorialContentView: View {
        
        @ObservedObject var viewModel: ProfileTutorialModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<viewModel.tutorials.count) { i in
                    OneSDropDown(.shortBig, title: viewModel.tutorials[i].title) {
                        OneSTutorialGIFView(tutorial: viewModel.tutorials[i].tutorial)
                            .frame(height: viewModel.tutorials[i].tutorial.popupHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .contentShape(Rectangle())
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
