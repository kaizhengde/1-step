//
//  ProfileAccomplishmentsSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAccomplishmentsSectionView: View {
    
    @StateObject private var userDefaultsManager = UserDefaultsManager.shared
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: Localized.accomplishments) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if !GoalAccomplishmentsHandler.noAccomplishments() {
                        ForEach(0..<profileModel.accomplishmentsData.count) { i in
                            Group {
                                if profileModel.accomplishmentsData[i].value != 0 {
                                    Item(profileModel: profileModel, index: i)
                                } else {
                                    EmptyView()
                                }
                            }
                            .oneSItemTransition(after: profileModel.accomplishmentsData[i].appearDelay)
                        }
                    } else {
                        EmptyItem()
                    }
                }
                .offset(x: Layout.firstLayerPadding)
                .frame(height: 160)
                .padding(.trailing, 2*Layout.firstLayerPadding)
            }
            .padding(.leading, -Layout.firstLayerPadding)
            .offset(y: -10)
        }
        .padding(.leading, Layout.firstLayerPadding)
    }
    
    
    struct Item: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @ObservedObject var profileModel: ProfileModel
        
        let index: Int
        
        
        var body: some View {
            HStack() {
                VStack(alignment: .leading) {
                    OneSText(text: "\(profileModel.accomplishmentsData[index].value)", font: .custom(.extraBold, 36), color: .backgroundToGray)
                    OneSText(text: profileModel.accomplishmentsData[index].description, font: .custom(.medium, 17), color: .backgroundToGray)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.top, 16)
            .frame(width: 240, height: 140)
            .background(profileModel.accomplishmentsData[index].color)
            .cornerRadius(10)
            .oneSShadow(opacity: 0.1, blur: 10)
            .oneSItemScaleTapGesture()
        }
    }
    
    
    struct EmptyItem: View {
        
        var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.lightNeutralToLightGray, lineWidth: 1)
                .frame(width: 240, height: 140)
        }
    }
}
