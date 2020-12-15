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
    var notification: GoalNotification?
    
    var editMode: Bool { notification != nil }
    
    
    var body: some View {
        VStack(spacing: 32) {
            //Header
            HStack(alignment: .titleSecondaryButtonAlignment) {
                OneSSecondaryHeaderText(text: editMode ? Localized.editReminder : Localized.newReminder, color: .backgroundToGray)
                    .alignmentGuide(.titleSecondaryButtonAlignment) { $0[VerticalAlignment.center] }
                    
                Spacer()
                
                VStack(spacing: 10) {
                    OneSSmallBorderButton(symbol: SFSymbol.check, color: .backgroundToGray, withScale: false) {
                        guard !viewModel.selectedData.weekdays.isEmpty else {
                            PopupManager.shared.showPopup(backgroundColor: viewModel.goal.color.standard, hapticFeedback: true) {
                                OneSTextPopupView(titleText: Localized.ohDeer, titleImage: Symbol.deer, bodyText: Localized.Notification.goal_errorNoDaySelected)
                            }
                            return
                        }
                        
                        if editMode { viewModel.editButtonPressed(with: notification!) }
                        else { viewModel.saveButtonPressed() }
                    }
                    .alignmentGuide(.titleSecondaryButtonAlignment) { $0[VerticalAlignment.center] }
                    
                    if editMode {
                        OneSSmallBorderButton(symbol: SFSymbol.delete, color: .backgroundToGray, withScale: false) {
                            viewModel.deleteButtonPressed(with: notification!)
                        }
                    }
                }
            }
            
            //Time
            OneSSectionView(title: Localized.atTime, titleColor: .backgroundToGray) {
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
            OneSSectionView(title: Localized.repeatEvery, titleColor: .backgroundToGray) {
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
        
        var selected: Bool { viewModel.selectedData.weekdays.contains(Int16(index)) }
        
        
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
                else { viewModel.selectedData.weekdays.append(Int16(index)) }
            }
        }
    }
}
