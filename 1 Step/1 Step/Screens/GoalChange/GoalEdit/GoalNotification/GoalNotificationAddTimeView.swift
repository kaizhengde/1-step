//
//  GoalNotificationAddTimeView.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalNotificationAddTimeView: View {
    
    @State private var selectedDate = Date()
    @State private var selectedDays: [(description: String, selected: Bool)] = [
        ("Mo", false),
        ("Tu", false),
        ("We", false),
        ("Th", false),
        ("Fr", false),
        ("Sa", false),
        ("Su", false)
    ]
    
    var selectedColor: UserColor
    
    
    var body: some View {
        VStack(spacing: 32) {
            OneSSectionView(title: "At time", titleColor: .backgroundToGray) {
                DatePicker(selectedDate.toTimeString(), selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .font(OneSFont.custom(.bold, 17).font)
                    .accentColor(selectedColor.light)
                    .foregroundColor(.whiteToDarkGray)
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .frame(width: Layout.firstLayerWidth, height: 55)
                    .background(selectedColor.dark)
                    .cornerRadius(12)
                    .contentShape(Rectangle())
            }
            
            OneSSectionView(title: "Repeat every", titleColor: .backgroundToGray) {
                VStack(spacing: 10) {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 10) {
                        ForEach(0..<selectedDays.count) { i in
                            WeekDayButton(selectedDays: $selectedDays, i: i, selectedColor: selectedColor)
                        }
                    }
                }
            }
        }
    }
    
    
    private struct WeekDayButton: View {
        
        @Binding var selectedDays: [(description: String, selected: Bool)]
        
        var i: Int
        var selectedColor: UserColor
        
        
        var body: some View {
            OneSFillButton(
                text:           selectedDays[i].description,
                textFont:       .subtitle,
                textColor:      selectedDays[i].selected ? .grayToBackground : .backgroundToGray,
                buttonColor:    selectedDays[i].selected ? .backgroundToGray : selectedColor.dark,
                height:         55,
                withScale:      false
            ) {
                selectedDays[i].selected.toggle()
            }
        }
    }
}
