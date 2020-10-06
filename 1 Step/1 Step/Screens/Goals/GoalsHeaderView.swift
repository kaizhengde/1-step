//
//  GoalsHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsHeaderView: View {
    
    var body: some View {
        VStack {
            OneSHeaderView("Goals", trailingButton: (.profile, .grayToBackground, { print("toProfile") }))
            TabBarView()
        }
    }
    
    
    private struct TabBarView: View {
        
        var body: some View {
            VStack {
                HStack {
                    Text("Hi")
                }
            }
        }
    }
}
