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
    
    @Binding var stopped: Bool
    @State var stoppedLeft: Bool = true
    @State var stoppedRight: Bool = true
    
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
                stopped: Binding<Bool>(
                    get: { stoppedLeft },
                    set: {
                        stoppedLeft = $0
                        stopped = $0
                    }
                ),
                unit: unit.left,
                selectedColor: selectedColor,
                width: 60
            )
            
            OneSPicker(
                data: Binding<[String]>(
                    get: {
                        if selectedLeft == 0 || selectedLeft == 1 { return [] }
                        return dataRight
                    },
                    set: { dataRight = $0 }
                ),
                selected: $selectedRight,
                stopped: Binding<Bool>(
                    get: { stoppedRight },
                    set: {
                        stoppedRight = $0
                        stopped = $0
                    }
                ),
                unit: unit.right,
                selectedColor: selectedColor,
                width: 60
            )
        }
    }
}
