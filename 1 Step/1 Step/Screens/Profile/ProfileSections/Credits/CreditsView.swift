//
//  SpecialThanksView.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI

struct CreditsView: View {
    
    @StateObject private var viewModel = CreditsModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView("Credits", trailingButton: (.close, .grayToBackground, { SheetManager.shared.dismiss() }), isInsideSheet: true)
                    
                    HStack {
                        OneSSecondaryHeaderText(text: "Gratitude towards", color: viewModel.color)
                        Spacer()
                    }
                    
                    CreditsContentView(viewModel: viewModel)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.bottom, 80*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct CreditsContentView: View {
        
        @ObservedObject var viewModel: CreditsModel
        
        
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
}
