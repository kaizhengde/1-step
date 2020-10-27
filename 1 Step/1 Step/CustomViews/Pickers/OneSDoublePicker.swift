//
//  OneSDoublePicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct OneSDoublePicker: View {
    
    @State var selected = (left: 9, right: 9)
    

    var data: (left: [String], right: [String])
    var unit: (left: String, right: String)
    
    var selectedColor: Color


    var body: some View {
        HStack {
            OneSPicker(selected: $selected.left, data: data.left, unit: unit.left, selectedColor: selectedColor, width: 60)
            OneSPicker(selected: $selected.right, data: data.right, unit: unit.right, selectedColor: selectedColor, width: 60)
        }
    }
}
