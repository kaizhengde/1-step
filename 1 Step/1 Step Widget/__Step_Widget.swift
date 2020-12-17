//
//  __Step_Widget.swift
//  1 Step Widget
//
//  Created by Kai Zheng on 17.12.20.
//

import WidgetKit
import SwiftUI
import Intents

struct GoalEntry: TimelineEntry {
    let date: Date
}


struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> GoalEntry {
        return GoalEntry(date: Date())
    }
    
    
    func getSnapshot(in context: Context, completion: @escaping (GoalEntry) -> Void) {
        
    }
    
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GoalEntry>) -> Void) {
        
    }
}
