//
//  GoalNotificationAddTimeView.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalChangeNotificationAddTimeView: View {
    
    @ObservedObject var viewModel: GoalChangeNotificationModel
    var selectedColor: UserColor
    
    
    var body: some View {
        VStack(spacing: 32) {
            //Header
            HStack {
                OneSSecondaryHeaderText(text: "New Reminder", color: .backgroundToGray)
                Spacer()
                OneSSmallBorderButton(symbol: SFSymbol.check, color: .backgroundToGray, withScale: false) {
                    viewModel.finishButtonPressed() 
                }
            }
            
            //Time
            OneSSectionView(title: "At time", titleColor: .backgroundToGray) {
                DatePicker(viewModel.selectedData.time.toTimeString(), selection: $viewModel.selectedData.time, displayedComponents: .hourAndMinute)
                    .font(OneSFont.custom(.bold, 17).font)
                    .accentColor(selectedColor.light)
                    .foregroundColor(.whiteToDarkGray)
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .frame(width: Layout.firstLayerWidth, height: 55)
                    .background(selectedColor.dark)
                    .cornerRadius(12)
                    .contentShape(Rectangle())
            }
            
            //Weekdays
            OneSSectionView(title: "Repeat every", titleColor: .backgroundToGray) {
                VStack(spacing: 10) {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 10) {
                        ForEach(0..<viewModel.weekdaysData.count) { i in
                            WeekDayButton(viewModel: viewModel, index: i, selectedColor: selectedColor)
                        }
                    }
                }
            }
        }
    }
    
    
    private struct WeekDayButton: View {
        
        @ObservedObject var viewModel: GoalChangeNotificationModel
        
        var index: Int
        var selectedColor: UserColor
        
        var selected: Bool { viewModel.selectedData.weekdays.contains(index) }
        
        
        var body: some View {
            OneSFillButton(
                text:           viewModel.weekdaysData[index],
                textFont:       .subtitle,
                textColor:      selected ? .grayToBackground : .backgroundToGray,
                buttonColor:    selected ? .backgroundToGray : selectedColor.dark,
                height:         55,
                withScale:      false
            ) {
                if selected { viewModel.selectedData.weekdays.removeAll { $0 == index } }
                else { viewModel.selectedData.weekdays.append(index) }
            }
        }
    }
}
