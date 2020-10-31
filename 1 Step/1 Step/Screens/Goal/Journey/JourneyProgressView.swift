//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct JourneyProgressView: View {
    
    @Binding var goal: Goal
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .frame(width: 12, height: 1000)
            .foregroundColor(.whiteToDarkGray)
    }
}
