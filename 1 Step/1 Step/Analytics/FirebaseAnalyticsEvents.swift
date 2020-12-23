//
//  AnalyticEvents.swift
//  1 Step
//
//  Created by Kai Zheng on 22.12.20.
//

import Foundation
import FirebaseAnalytics

enum FirebaseAnalyticsEvent {
    
    enum Premium {
        
        static let openView: () -> ()               = { Analytics.logEvent("premium_open_view", parameters: nil) }
        static let openRealTreeInfo: () -> ()       = { Analytics.logEvent("premium_open_realTreeInfo", parameters: nil) }
            
        static let purchasingPremium1: () -> ()     = { Analytics.logEvent("premium_purchasing_premium1", parameters: nil) }
        static let purchasingPremium2: () -> ()     = { Analytics.logEvent("premium_purchasing_premium2", parameters: nil) }
        static let purchasedPremium1: () -> ()      = { Analytics.logEvent("premium_purchased_premium1", parameters: nil) }
        static let purchasedPremium2: () -> ()      = { Analytics.logEvent("premium_purchased_premium2", parameters: nil) }
        static let canceledPremium1: () -> ()       = { Analytics.logEvent("premium_canceled_premium1", parameters: nil) }
        static let canceledPremium2: () -> ()       = { Analytics.logEvent("premium_canceled_premium2", parameters: nil) }
        static let refundSuccessful: () -> ()       = { Analytics.logEvent("premium_refund_successful", parameters: nil) }
        static let refundFailed: () -> ()           = { Analytics.logEvent("premium_refund_failed", parameters: nil) }
    }
    
    
    enum Profile {
        
        static func toggleAppearance(to value: OneSAppearance) {
            Analytics.logEvent("profile_toggle_appearance", parameters: ["value": value.rawValue])
        }
        
        static func toggleTheme(to value: OneSColorTheme) {
            Analytics.logEvent("profile_toggle_theme", parameters: ["value": value.rawValue])
        }
        
        static func toggleICloud(to value: Bool) {
            Analytics.logEvent("profile_toggle_iCloud", parameters: ["value": String(value)])
        }
        
        static func toggleBiometrics(to value: Bool) {
            Analytics.logEvent("profile_toggle_biometrics", parameters: ["value": String(value)])
        }
        
        static let openHelp: () -> ()           = { Analytics.logEvent("profile_open_help", parameters: nil) }
        static let openTutorial: () -> ()       = { Analytics.logEvent("profile_open_tutorial", parameters: nil) }
        static let openRateOnAppStore: () -> () = { Analytics.logEvent("profile_open_rateOnAppStore", parameters: nil)}
        static let openShare: () -> ()          = { Analytics.logEvent("profile_open_share", parameters: nil) }
        static let openWebsite: () -> ()        = { Analytics.logEvent("profile_open_website", parameters: nil) }
        static let openInstagram: () -> ()      = { Analytics.logEvent("profile_open_instagram", parameters: nil) }
        static let openVfdCollective: () -> ()  = { Analytics.logEvent("profile_open_vfdCollective", parameters: nil) }
        static let openPastelTree: () -> ()     = { Analytics.logEvent("profile_open_pastelTree", parameters: nil) }
        static let openPlantTree: () -> ()      = { Analytics.logEvent("profile_open_plantTree", parameters: nil) }
    }

    
    enum GoalInfo {
        
        static let openHowItWorks: () -> ()         = { Analytics.logEvent("profile_open_howItWorks", parameters: nil) }
        static let openExamples: () -> ()           = { Analytics.logEvent("profile_open_examples", parameters: nil) }
        static let openParticularExample: () -> ()  = { Analytics.logEvent("profile_open_particular_example", parameters: nil) }
    }
    
    
    enum Goal {
        
        static let create: () -> ()                 = { Analytics.logEvent("goal_create", parameters: nil) }
        static let created: () -> ()                = { Analytics.logEvent("goal_created", parameters: nil) }
        static let createError: () -> ()            = { Analytics.logEvent("goal_create_error", parameters: nil) }
        static let deleted: () -> ()                = { Analytics.logEvent("goal_delete", parameters: nil) }
        static let edited: () -> ()                 = { Analytics.logEvent("goal_edited", parameters: nil) }
        
        static func selectedMountain(mountain: MountainImage) {
            Analytics.logEvent("goal_selected_mountain", parameters: ["value": mountain.rawValue])
        }
        
        static func selectedColor(color: UserColor) {
            Analytics.logEvent("goal_selected_color", parameters: ["value": color.rawValue])
        }
        
        static let neededStepUnits: () -> ()        = { Analytics.logEvent("goal_neededStepUnits", parameters: nil) }
        static let customUnit: () -> ()             = { Analytics.logEvent("goal_custom_unit", parameters: nil) }
        static let nameLength: () -> ()             = { Analytics.logEvent("goal_name_length", parameters: nil) }
        static let customUnitLength: () -> ()       = { Analytics.logEvent("goal_custom_unit_length", parameters: nil) }
        
        static let addSteps: () -> ()               = { Analytics.logEvent("goal_add_steps", parameters: nil) }
        static let addNegativeSteps: () -> ()       = { Analytics.logEvent("goal_add_negative_steps", parameters: nil) }
        static let addTimeReminder: () -> ()        = { Analytics.logEvent("goal_add_time_reminder", parameters: nil) }
        
        static let reorderSortOrder: () -> ()       = { Analytics.logEvent("goal_reorderSortOrder", parameters: nil) }
    }
    
    
    enum GoalView {
        
        static let buttonToMenu: () -> ()           = { Analytics.logEvent("goalView_button_to_menu", parameters: nil) }
        static let buttonToGoals: () -> ()          = { Analytics.logEvent("goalView_button_to_goals", parameters: nil) }
        static let dragToMenu: () -> ()             = { Analytics.logEvent("goalView_drag_to_menu", parameters: nil) }
        static let dragToGoalsDirectly: () -> ()    = { Analytics.logEvent("goalView_drag_to_goals_directly", parameters: nil) }
        static let dragToGoalsFromMenu: () -> ()    = { Analytics.logEvent("goalView_drag_to_goals_from_menu", parameters: nil) }
    }
}
