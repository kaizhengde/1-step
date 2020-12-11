//
//  NotificationHelper.swift
//  1 Step
//
//  Created by Kai Zheng on 11.12.20.
//

import Foundation

enum NotificationHelper {
    
    
    //MARK: - Greeting
    
    static func generateNotificationGreeting(from dateComponents: DateComponents) -> String {
        var greeting: (text: String, withComma: Bool) = ("", false)
        
        switch dateComponents.hour! {
        case 4...10:    greeting = getRandomGreeting("Good morning")
        case 11...13:   greeting = getRandomGreeting()
        case 14...17:   greeting = getRandomGreeting("Good afternoon")
        case 18...21:   greeting = getRandomGreeting("Good evening")
        default:        greeting = getRandomGreeting()
        }
        
        let userName    = UserDefaultsManager.shared.userName
        let emoji       = getRandomEmoji()
        
        switch Int.random(in: 0...3) {
        case 0: greeting.text.append((greeting.withComma ? "," : "") + " \(userName) \(emoji).")
        case 1: greeting.text.append((greeting.withComma ? "," : "") + " \(userName)!")
        case 2: greeting.text.append((greeting.withComma ? "," : "") + " \(userName).")
        case 3: greeting.text.append(" \(emoji).")
        case 4: greeting.text.append("!")
        case 5: greeting.text.append(".")
        default: break
        }
        
        return greeting.text
    }
    
    
    static func getRandomGreeting(_ dayTime: String? = nil) -> (String, Bool) {
        var greeting: (text: String, withComma: Bool) = ("", false)
        
        switch Int.random(in: 0...2) {
        case 0: greeting.text = "Hey"
        case 1: greeting.text = "Hi"
        case 2: greeting = ("Greetings", true)
        default: break
        }
        
        if let dayTime = dayTime {
            switch Int.random(in: 0...1) {
            case 0: greeting = (dayTime, true)
            default: break
            }
        }
        
        return greeting
    }
    
    
    static func getRandomEmoji() -> String {
        switch Int.random(in: 0...1) {
        case 0:     return "🙂"
        default:    return "👋"
        }
    }
}
