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
        case 4...9:     greeting = (Localized.goodMorning, true)
        case 18...21:   greeting = (Localized.goodEvening, true)
        default:        greeting.text = getRandomGreeting()
        }
        
        let userName    = UserDefaultsManager.shared.userName
        let emoji       = getRandomEmoji()
        
        switch Int.random(in: (!userName.isEmpty ? 0 : 3)...5) {
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
    
    
    static func getRandomGreeting() -> String {
        switch Int.random(in: 0...1) {
        case 0:     return Localized.hey
        default:    return Localized.hi
        }
    }
    
    
    static func getRandomEmoji() -> String {
        switch Int.random(in: 0...1) {
        case 0:     return "🙂"
        default:    return "👋"
        }
    }
}
