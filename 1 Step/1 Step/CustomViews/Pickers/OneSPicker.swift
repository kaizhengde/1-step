//
//  OneSPicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

//struct OneSPicker: View {
//
//    @State private var selections: [Int] = [0]
//
//    var data: [String]
//    var selectedData: String { return data[selections[0]] }
//
//
//    var body: some View {
//        PickerView(data: [data].reversed(), selections: $selections)
//            .frame(width: 100, height: 60)
//    }
//}

struct OneSPicker: View {
    
    @Binding var data: [String]
    @Binding var selected: Int
    
    var unit: String
    
    var selectedColor: Color
    var width: CGFloat
    
    private var multiplier: CGFloat = 150/90
    
    
    init(data: Binding<[String]>, selected: Binding<Int>, unit: String, selectedColor: Color, width: CGFloat = 90) {
        self._data = data
        self._selected = selected
        self.unit = unit
        self.selectedColor = selectedColor
        self.width = width
    }


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: width, height: 32)
                .foregroundColor(selectedColor)
            
            Picker("", selection: $selected) {
                ForEach(0 ..< data.count, id: \.self) { i in
                    if i == selected {
                        HStack(spacing: 1.5) {
                            OneSText(text: data[data.count-1-i], font: .title2, color: .backgroundStatic)
                            OneSText(text: unit, font: .custom(weight: Raleway.semiBold, size: 12), color: .backgroundStatic)
                        }
                    } else {
                        OneSText(text: data[data.count-1-i], font: .title2, color: .backgroundStatic)
                    }
                }
            }
        }
        .frame(width: width*multiplier, height: 150)
        .scaleEffect(1.7)
        .clipped()
        .contentShape(Rectangle())
        .onChange(of: data) { selected = $0.count-1 }
    }
}


