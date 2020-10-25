//
//  OneSDoublePicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct OneSDoublePicker: View {
    
    @State private var selections: [Int] = [0, 0]
    
    var data: (left: [String], right: [String])
    var selectedData: (left: String, right: String) { return (data.left[selections[0]], data.right[selections[1]]) }
    
    
    var body: some View {
        Text("hi")
    }
}


