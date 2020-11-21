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
            LazyVStack(spacing: 20) {
                OneSRowButton(.long, title: "Website", accessorySFSymbol: ProfileSymbol.website) {}
                
                OneSRowButton(.long, title: "Share", accessorySFSymbol: ProfileSymbol.share) {}
                
                OneSRowButton(.long, title: "Rate on the App Store", accessorySFSymbol: ProfileSymbol.rate) {}
                
                OneSRowButton(.long, title: "Send your Feedback", accessorySFSymbol: ProfileSymbol.feedback) {}
                
                OneSRowButton(.long, title: "The VFD Collective", accessorySFSymbol: ProfileSymbol.vfdCollective) {}
                
                OneSRowButton(.long, title: "Pastel Tree", accessorySFSymbol: ProfileSymbol.pastelTree) {}
            }
        }
    }
}
