//
//  GoalNotificationModel.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalNotificationData {
    
    var time: Date
    var weekdays: [Int]
}


class GoalNotificationModel: ObservableObject {
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    @Published var selectedData: GoalNotificationData = GoalNotificationData(time: Date(), weekdays: [])
    
    lazy var weekdaysData: [String] = {
        let formatter = DateFormatter()
        var weekdays = formatter.shortStandaloneWeekdaySymbols!
        
        let firstWeekday = 2
        weekdays = Array(weekdays[firstWeekday-1..<weekdays.count]) + weekdays[0..<firstWeekday-1]
        
        return weekdays
    }()

    
    //MARK: - Data
    
    func finishButtonPressed() {
        MiniSheetManager.shared.dismiss()
    }
    
    
    func resetSelectedData() {
        selectedData = GoalNotificationData(time: Date(), weekdays: [])
    }
}
