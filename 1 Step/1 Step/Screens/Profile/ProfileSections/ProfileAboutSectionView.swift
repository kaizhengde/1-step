//
//  ProfileAboutSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAboutSectionView: View {
    
    @StateObject private var userDefaultsManager = UserDefaultsManager.shared
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: "About") {
            VStack(spacing: 20) {
                OneSRowButton(.long, title: "Share", accessorySFSymbol: ProfileSymbol.share, accessoryColor: UserColor.user0.standard) {}
                
                OneSRowButton(.long, title: "Rate on the App Store", accessorySFSymbol: ProfileSymbol.rate, accessoryColor: UserColor.user1.standard) {}
                
                OneSRowButton(.long, title: "Send your Feedback", accessorySFSymbol: ProfileSymbol.feedback, accessoryColor: UserColor.user1.standard) {}
                
                OneSRowButton(.long, title: "Website", accessorySFSymbol: ProfileSymbol.website, accessoryColor: UserColor.user2.standard) {}
                
                OneSRowButton(.long, title: "The VFD Collective", accessorySFSymbol: ProfileSymbol.vfdCollective, accessoryColor: UserColor.user2.standard) {}
                
                OneSRowButton(.long, title: "Pastel Tree", accessorySFSymbol: ProfileSymbol.pastelTree, accessoryColor: UserColor.user2.standard) {}
            }
        }
    }
}
