//
//  OneSDoublePicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct OneSDualPicker: View {
    
    @Binding var selectedLeft: Int
    @Binding var selectedRight: Int
    

    var data: (left: [String], right: [String])
    var unit: (left: String, right: String)
    
    var selectedColor: Color


    var body: some View {
        HStack {
            OneSPicker(selected: $selectedLeft, data: data.left, unit: unit.left, selectedColor: selectedColor, width: 60)
            OneSPicker(selected: $selectedRight, data: data.right, unit: unit.right, selectedColor: selectedColor, width: 60)
        }
    }
}
