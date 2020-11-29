//
//  OneSRowSelectButton.swift
//  1 Step
//
//  Created by Kai Zheng on 20.11.20.
//

import SwiftUI

struct OneSRowSelectButton: View {
    
    @Binding var selected: Bool
    
    let title: String
    let selectedColor: Color
    let action: () -> ()
    
    
    init(_ selected: Binding<Bool>, title: String, selectedColor: Color, action: @escaping () -> ()) {
        self._selected = selected
        self.title = title
        self.selectedColor = selectedColor
        self.action = action
    }
    
    
    var body: some View {
        Button(
            action: {
                OneSFeedback.light()
                action()
            }
        ) {
            HStack {
                OneSText(text: title, font: .custom(selected ? .bold : .medium, 17), color: selected ? selectedColor : .darkNeutralToNeutral)
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
            .frame(width: 280*Layout.multiplierWidth, height: 56)
            .cornerRadius(10)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selected ? selectedColor : .lightNeutralToLightGray, lineWidth: 1)
            )
        }
        .oneSItemTransition()
    }
}
