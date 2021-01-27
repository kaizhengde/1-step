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
        
        static func toggleAppIcon(to value: OneSAppIcon) {
            Analytics.logEvent("profile_toggle_appIcon", parameters: ["value": value.rawValue])
        }
        
        static func toggleICloud(to value: Bool) {
            Analytics.logEvent("profile_toggle_iCloud", parameters: ["value": String(value)])
        }
        
        static func toggleBiometrics(to value: Bool) {
            Analytics.logEvent("profile_toggle_biometrics", parameters: ["value": String(value)])
        }
        
        static let addProfilePicture: () -> ()  = { Analytics.logEvent("profile_add_profilePicture", parameters: nil) }
        
        static let openHelp: () -> ()           = { Analytics.logEvent("profile_open_help", parameters: nil) }
        static let openTutorial: () -> ()       = { Analytics.logEvent("profile_open_tutorial", parameters: nil) }
        static let openRateOnAppStore: () -> () = { Analytics.logEvent("profile_open_rateOnAppStore", parameters: nil)}
        static let openShare: () -> ()          = { Analytics.logEvent("profile_open_share", parameters: nil) }
        static let openWebsite: () -> ()        = { Analytics.logEvent("profile_open_website", parameters: nil) }
        static let openInstagram: () -> ()      = { Analytics.logEvent("profile_open_instagram", parameters: nil) }
        static let openVfdCollective: () -> ()  = { Analytics.logEvent("profile_open_vfdCollective", parameters: nil) }
        static let openPlantTree: () -> ()      = { Analytics.logEvent("profile_open_plantTree", parameters: nil) }
        static let openPrivacyPolicy: () -> ()  = { Analytics.logEvent("profile_open_privacyPolicy", parameters: nil) }
        static let openTermsOfUse: () -> ()     = { Analytics.logEvent("profile_open_termsOfUse", parameters: nil) }
        static let openCredits: () -> ()        = { Analytics.logEvent("profile_open_credits", parameters: nil) }
    }

    
    enum GoalInfo {
        
        static let openHowItWorks: () -> ()         = { Analytics.logEvent("profile_open_howItWorks", parameters: nil) }
        static let openExamples: () -> ()           = { Analytics.logEvent("profile_open_examples", parameters: nil) }
        static let tapOnParticularExample: () -> () = { Analytics.logEvent("profile_tapOn_particular_example", parameters: nil) }
    }
    
    
    enum Goal {
        
        static let openCreate: () -> ()             = { Analytics.logEvent("goal_openCreate", parameters: nil) }
        static let insert: () -> ()                 = { Analytics.logEvent("goal_insert", parameters: nil) }
        static let delete: () -> ()                 = { Analytics.logEvent("goal_delete", parameters: nil) }
        static let edit: () -> ()                   = { Analytics.logEvent("goal_edit", parameters: nil) }
        static let createFailed: () -> ()           = { Analytics.logEvent("goal_create_failed", parameters: nil) }
        static let editFailed: () -> ()             = { Analytics.logEvent("goal_edit_failed", parameters: nil) }
        static let reached: () -> ()                = { Analytics.logEvent("goal_reached", parameters: nil)}

        static func goalsCount(_ count: Int) {
            Analytics.logEvent("goal_goals_count", parameters: ["value": count])
        }
        static func activeGoalsCount(_ count: Int) {
            Analytics.logEvent("goal_activeGoals_count", parameters: ["value": count])
        }
        static func reachedGoalsCount(_ count: Int) {
            Analytics.logEvent("goal_reachedGoals_count", parameters: ["value": count])
        }
        
        static func selectMountain(_ mountain: MountainImage) {
            Analytics.logEvent("goal_select_mountain", parameters: ["value": mountain.rawValue])
        }
        static func selectColor(_ color: UserColor) {
            Analytics.logEvent("goal_select_color", parameters: ["value": color.rawValue])
        }
        
        static func nameLength(_ value: Int) {
            Analytics.logEvent("goal_name_length", parameters: ["value": value])
        }
        static func neededStepUnits(_ value: Int16) {
            Analytics.logEvent("goal_neededStepUnits", parameters: ["value": Int(value)])
        }
        static func stepCategory(_ category: StepCategory) {
            Analytics.logEvent("goal_step_unit_category", parameters: ["value": category.rawValue])
        }
        
        static func customUnitLength(_ value: Int) {
            Analytics.logEvent("goal_custom_unit_length", parameters: ["value": value])
        }
        static let customUnit: () -> ()             = { Analytics.logEvent("goal_custom_unit", parameters: nil) }
        
        static let addSteps: () -> ()               = { Analytics.logEvent("goal_add_steps", parameters: nil) }
        static let addNegativeSteps: () -> ()       = { Analytics.logEvent("goal_add_negative_steps", parameters: nil) }
        static let addTimeReminder: () -> ()        = { Analytics.logEvent("goal_add_time_reminder", parameters: nil) }
        static let moveGoal: () -> ()               = { Analytics.logEvent("goal_moveGoal", parameters: nil) }
        
        static func milestonesCount(_ count: Int) {
            Analytics.logEvent("goal_milestones_count", parameters: ["value": count])
        }
        static func timeRemindersCount(_ count: Int) {
            Analytics.logEvent("goal_time_reminders_count", parameters: ["value": count])
        }
    }
    
    
    enum GoalScreen {
        
        static let toMenu: () -> ()                     = { Analytics.logEvent("goalScreen_to_menu", parameters: nil) }
        static let toGoals: () -> ()                    = { Analytics.logEvent("goalScreen_to_goals", parameters: nil) }
        static let buttonToMenu: () -> ()               = { Analytics.logEvent("goalScreen_button_to_menu", parameters: nil) }
        static let buttonToGoals: () -> ()              = { Analytics.logEvent("goalScreen_button_to_goals", parameters: nil) }
        static let dragToMenu: () -> ()                 = { Analytics.logEvent("goalScreen_drag_to_menu", parameters: nil) }
        static let dragToGoalsDirectly: () -> ()        = { Analytics.logEvent("goalScreen_drag_to_goals_directly", parameters: nil) }
        static let dragToGoalsFromMenu: () -> ()        = { Analytics.logEvent("goalScreen_drag_to_goals_from_menu", parameters: nil) }
        
        static let scrollToJourneyView: () -> ()        = { Analytics.logEvent("goalScreen_scroll_to_journeyView", parameters: nil) }
        static let downArrowToJourneyView: () -> ()     = { Analytics.logEvent("goalScreen_downArrow_to_journeyView", parameters: nil) }
        
        static let addStepsFromSummaryView: () -> ()    = { Analytics.logEvent("goalScreen_addSteps_from_summaryView", parameters: nil) }
        static let addStepsFromJourneyView: () -> ()    = { Analytics.logEvent("goalScreen_addSteps_from_journeyView", parameters: nil) }
    }
}
