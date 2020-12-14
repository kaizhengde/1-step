//
//  Localized.swift
//  1 Step
//
//  Created by Kai Zheng on 24.11.20.
//

import SwiftUI

enum Localized {
    
    static let goals            = "goals".localized()
    static let active           = "active".localized()
    static let reached          = "reached".localized()
    static let profile          = "profile".localized()
    static let edit             = "edit".localized()
    static let accomplishments  = "accomplishments".localized()
    static let app              = "app".localized()
    static let about            = "about".localized()
    static let settings         = "settings".localized()
    static let dataAndPrivacy   = "dataAndPrivacy".localized()
    static let help             = "help".localized()
    static let share            = "share".localized()
    static let requestFeatures  = "requestFeatures".localized()
    static let rateOnAppStore   = "rateOnAppStore".localized()
    static let sendFeedback     = "sendFeedback".localized()
    static let website          = "website".localized()
    static let instagram        = "instagram".localized()
    static let vfdCollective    = "vfdCollective".localized()
    static let pastelTree       = "pastelTree".localized()
    static let plantTree        = "plantTree".localized()
    static let premium          = "premium".localized()
    static let language         = "language".localized()
    static let english          = "english".localized()
    static let german           = "german".localized()
    static let appearance       = "appearance".localized()
    static let mirrorDevice     = "mirrorDevice".localized()
    static let light            = "light".localized()
    static let dark             = "dark".localized()
    static let theme            = "theme".localized()
    static let water            = "water".localized()
    static let earth            = "earth".localized()
    static let air              = "air".localized()
    static let notifications    = "notifications".localized()
    static let iCloudSync       = "iCloudSync".localized()
    static let exportData       = "exportData".localized()
    static let resetAllData     = "resetAllData".localized()
    static let privacyPolicy    = "privacyPolicy".localized()
    static let summit           = "summit".localized()
    static let milestone        = "milestone".localized()
    static let goal             = "goal".localized()
    static let selectUnit       = "selectUnit".localized()
    static let unit             = "unit".localized()
    static let select           = "select".localized()
    static let on               = "on".localized()
    static let off              = "off".localized()
    static let yes              = "yes".localized()
    static let no               = "no".localized()
    static let credits          = "credits".localized()
    static let terms            = "terms".localized()
    static let current          = "current".localized()
    static let reminders        = "reminders".localized()
    static let newReminder      = "newReminder".localized()
    static let editReminder     = "editReminder".localized()
    static let atTime           = "atTime".localized()
    static let repeatEvery      = "repeatEvery".localized()
    static let custom           = "custom".localized()
    static let plant            = "plant".localized()
    static let create           = "create".localized()
    static let everyDay         = "everyDay".localized()
    static let time             = "time".localized()
    static let ohDeer           = "ohDeer".localized()
    static let delete           = "delete".localized()
    static let lifetime         = "lifetime".localized()
    static let note             = "note".localized()
    static let thankYou         = "thankYou".localized()
    static let start            = "start".localized()
    static let gratitude        = "gratitude".localized()
    static let tutorial         = "tutorial".localized()
    static let selectMountain   = "selectMountain".localized()
    static let selectColor      = "selectColor".localized()
    static let goalBasics       = "goalBasics".localized()
    
    
    enum Step {
        
        static let category_duration            = "step.category_duration".localized()
        static let category_distance            = "step.category_distance".localized()
        static let category_reps                = "step.category_reps".localized()
        static let unit_h                       = "step.unit_h".localized()
        static let unit_min                     = "step.unit_min".localized()
        static let unit_km                      = "step.unit_km".localized()
        static let unit_m                       = "step.unit_m".localized()
        static let unit_miles                   = "step.unit_miles".localized()
        static let unit_feets                   = "step.unit_feets".localized()
        static let unit_times                   = "step.unit_times".localized()
        static let unit_pages                   = "step.unit_pages".localized()
        static let unit_steps                   = "step.unit_steps".localized()
        static let unit_decisions               = "step.unit_decisions".localized()
        static let unit_trees                   = "step.unit_trees".localized()
        static let unit_books                   = "step.unit_books".localized()
        static let unit_custom                  = "step.unit_custom".localized()
    }
    
    
    enum ProfileScreen {
        
        static let made                         = "profileScreen.made".localized()
        static let version                      = "profileScreen.version".localized()
        static let accomplishment_steps         = "profileScreen.accomplishment_steps".localized()
        static let accomplishment_milestones    = "profileScreen.accomplishment_milestones".localized()
        static let accomplishment_goals         = "profileScreen.accomplishment_goals".localized()
    }
    
    
    enum GoalChange {
        
        static let enterCustomUnit              = "goalChange.enterCustomUnit".localized()
        static let confirmDelete                = "goalChange.confirmDelete".localized()
    }
    
    
    enum GoalError {
        
        static let goalNameEmpty                = "goalError.goalNameEmpty".localized()
        static let stepsNeededEmpty             = "goalError.stepsNeededEmpty".localized()
        static let stepUnitEmpty                = "goalError.stepUnitEmpty".localized()
        static let stepCustomUnitEmpty          = "goalError.stepCustomUnitEmpty".localized()
        static let stepsNeededTooLittle         = "goalError.stepsNeededTooLittle".localized()
        static let stepsNeededTooMany           = "goalError.stepsNeededTooMany".localized()
        static let currentBelowNeededStepUnits  = "goalError.currentBelowNeededStepUnits".localized()
        static let changeOfCategory             = "goalError.changeOfCategory".localized()
        static let changeOfDistanceUnitsSystem  = "goalError.changeOfDistanceUnitsSystem".localized()
        static let unknown                      = "goalError.unknown".localized()
    }
    
    
    enum Premium {
        
        static let achieveEveryGoal     = "premium.achieveEveryGoal".localized()
        static let unlimitedGoals       = "premium.unlimitedGoals".localized()
        static let futureUpdates        = "premium.futureUpdates".localized()
        static let realTree             = "premium.realTree".localized()
        static let youChoose            = "premium.youChoose".localized()
        static let restore              = "premium.restore".localized()
        static let noteTextPassage      = "premium.noteTextPassage".localized()
        static let thankYouText         = "premium.thankYouText".localized()
    }
}

