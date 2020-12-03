//
//  OneSPicker.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI
import Combine

struct OneSPicker: View {
    
    @Binding var data: [String]
    @Binding var selected: Int
    @Binding var stopped: Bool
    
    var unit: String
    
    var selectedColor: Color
    var width: CGFloat
    
    private var multiplier: CGFloat = 150/90
    
    
    init(data: Binding<[String]>, selected: Binding<Int>, stopped: Binding<Bool>, unit: String, selectedColor: Color, width: CGFloat = 90) {
        self._data = data
        self._selected = selected
        self._stopped = stopped
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
                            OneSText(text: data.reversed()[i], font: .title2, color: .backgroundToBlack)
                            OneSText(text: unit, font: .custom(.semiBold, 12), color: .backgroundToBlack)
                        }
                    } else {
                        OneSText(text: data.reversed()[i], font: .title2, color: .backgroundToBlack)
                    }
                }
            }
            .simultaneousGesture(
                DragGesture().onChanged { _ in stopped = false }
            )
        }
        .frame(width: width*multiplier, height: 150)
        .scaleEffect(1.7)
        .clipped()
        .contentShape(Rectangle())
        .onChange(of: data) { selected = $0.count-1 }
        .onChange(of: selected) { _ in stopped = true }
    }
}


