//
//  GoalEnterInputSelectStepUnitView.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

struct GoalEnterInputSelectStepUnitView: View {
    
    let selectedColor: UserColor
    
    
    var body: some View {
        VStack {
            //StepCategory
            HStack {
                StepCategoryButton(stepCategory: .duration)
                Spacer()
                StepCategoryButton(stepCategory: .distance)
                Spacer()
                StepCategoryButton(stepCategory: .reps)
            }
            
            //StepUnit
        }
    }
    
    
    private struct StepCategoryButton: View {
        
        let stepCategory: StepCategory
        
        
        var body: some View {
            OneSFillButton(text: stepCategory.describtion, textFont: .custom(weight: Raleway.semiBold, size: 16), textColor: .backgroundToGray, buttonColor: .opacityBackgroundDarker, height: 55, withScale: false) {
                
            }
        }
    }
}
