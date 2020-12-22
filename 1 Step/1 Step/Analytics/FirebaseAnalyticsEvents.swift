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
        
        static let openView: Void               = Analytics.logEvent("premium_open_view", parameters: nil)
        static let openRealTreeInfo: Void       = Analytics.logEvent("premium_open_realTreeInfo", parameters: nil)
            
        static let purchasePremium1: Void       = Analytics.logEvent("premium_purchase_premium1", parameters: nil)
        static let purchasePremium2: Void       = Analytics.logEvent("premium_purchase_premium2", parameters: nil)
        static let purchasedPremium1: Void      = Analytics.logEvent("premium_purchased_premium1", parameters: nil)
        static let purchasedPremium2: Void      = Analytics.logEvent("premium_purchased_premium2", parameters: nil)
        static let canceledPremium1: Void       = Analytics.logEvent("premium_canceled_premium1", parameters: nil)
        static let canceledPremium2: Void       = Analytics.logEvent("premium_canceled_premium2", parameters: nil)
        static let refundSuccessful: Void       = Analytics.logEvent("premium_refund_successful", parameters: nil)
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
        
        static let openHelp: Void               = Analytics.logEvent("profile_open_help", parameters: nil)
        static let openTutorial: Void           = Analytics.logEvent("profile_open_tutorial", parameters: nil)
        static let openShare: Void              = Analytics.logEvent("profile_open_share", parameters: nil)
        static let openWebsite: Void            = Analytics.logEvent("profile_open_website", parameters: nil)
    }

    
    enum GoalInfo {
        
        static let openHowItWorks: Void         = Analytics.logEvent("profile_open_howItWorks", parameters: nil)
        static let openParticularExample: Void  = Analytics.logEvent("profile_open_particular_example", parameters: nil)
    }
    
    
    enum Goal {
        
        static let create: Void                 = Analytics.logEvent("goal_create", parameters: nil)
        static let created: Void                = Analytics.logEvent("goal_created", parameters: nil)
        static let createError: Void            = Analytics.logEvent("goal_create_error", parameters: nil)
        static let deleted: Void                = Analytics.logEvent("goal_delete", parameters: nil)
        static let edited: Void                 = Analytics.logEvent("goal_edited", parameters: nil)
        
        static func selectedMountain(mountain: MountainImage) {
            Analytics.logEvent("goal_selected_mountain", parameters: ["value": mountain.rawValue])
        }
        
        static func selectedColor(color: UserColor) {
            Analytics.logEvent("goal_selected_color", parameters: ["value": color.rawValue])
        }
        
        static let neededStepUnits: Void        = Analytics.logEvent("goal_neededStepUnits", parameters: nil)
        static let customUnit: Void             = Analytics.logEvent("goal_custom_unit", parameters: nil)
        static let nameLength: Void             = Analytics.logEvent("goal_name_length", parameters: nil)
        static let customUnitLength: Void       = Analytics.logEvent("goal_custom_unit_length", parameters: nil)
        
        static let addSteps: Void               = Analytics.logEvent("goal_add_steps", parameters: nil)
        static let addNegativeSteps: Void       = Analytics.logEvent("goal_add_negative_steps", parameters: nil)
        static let addTimeReminder: Void        = Analytics.logEvent("goal_add_time_reminder", parameters: nil)
        
        static let reorderSortOrder: Void       = Analytics.logEvent("goal_reorderSortOrder", parameters: nil)
    }
    
    
    enum GoalView {
        
        static let buttonToMenu: Void           = Analytics.logEvent("goalView_button_to_menu", parameters: nil)
        static let buttonToGoals: Void          = Analytics.logEvent("goalView_button_to_goals", parameters: nil)
        static let dragToMenu: Void             = Analytics.logEvent("goalView_drag_to_menu", parameters: nil)
        static let dragToGoalsDirectly: Void    = Analytics.logEvent("goalView_drag_to_goals_directly", parameters: nil)
        static let dragToGoalsFromMenu: Void    = Analytics.logEvent("goalView_drag_to_goals_from_menu", parameters: nil)
    }
}
