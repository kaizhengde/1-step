//
//  OneSDoublePicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct OneSDualPicker: View {
    
    @Binding var dataLeft: [String]
    @Binding var dataRight: [String]
    
    @Binding var selectedLeft: Int
    @Binding var selectedRight: Int
    
    var unit: (left: String, right: String)
    var selectedColor: Color

    var body: some View {
        HStack {
            OneSPicker(
                data: Binding<[String]>(
                    get: {
                        if selectedRight == 0 { return [] }
                        return dataLeft
                    },
                    set: { dataLeft = $0 }
                ),
                selected: $selectedLeft,
                unit: unit.left,
                selectedColor: selectedColor,
                width: 60
            )
            
            OneSPicker(
                data: Binding<[String]>(
                    get: {
                        if selectedLeft == 0 || selectedLeft == 1 { return [] }
                        if selectedLeft == dataLeft.count-1 { return dataRight.filter { $0 != "0" } }
                        return dataRight
                    },
                    set: { dataRight = $0 }
                ),
                selected: $selectedRight,
                unit: unit.right,
                selectedColor: selectedColor,
                width: 60
            )
        }
    }
}
