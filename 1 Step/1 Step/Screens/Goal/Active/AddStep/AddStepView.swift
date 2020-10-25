//
//  AddStepView.swift
//  1 Step
//
//  Created by Kai Zheng on 25.10.20.
//

import SwiftUI

struct AddStepView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel = AddStepModel()
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .trailing, vertical: .addStepAlignment)) {
            HStack {
                Spacer()
                HiddenView()
            }
            .alignmentGuide(.addStepAlignment) { d in d[VerticalAlignment.center] }
            .background(Color.red)
            
            HStack {
                Spacer()
                AddView()
            }
            .alignmentGuide(.addStepAlignment) { d in d[VerticalAlignment.center] }
            .background(Color.blue.opacity(0.4))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: -60 * Layout.multiplierHeight)
        .oneSAnimation(duration: 0.3)
    }
    
    
    private struct HiddenView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @StateObject private var viewModel = AddStepModel()
        
        
        var body: some View {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 140)
                .foregroundColor(goalModel.selectedGoal.color.get(.light))
                .oneSShadow(opacity: 0.12, x: 0, y: 2, blur: 8)
                .offset(x: viewModel.animate ? -5 : 0)
                .scaleEffect(y: viewModel.animate ? 1.05 : 1.0)
                .offset(x: viewModel.dragState == .show ? -50 : viewModel.dragOffset)
                .scaleEffect(y: viewModel.dragHiddenScaleEffect)
                .opacity(viewModel.dragHiddenOpacity)
                .overlay(
                    Group {
                        if goalModel.showAddStepDragArea {
                            Color.hidden.frame(width: 100, height: 300)
                        }
                    }
                )
                .padding(8)
                .highPriorityGesture(viewModel.dragGesture)
                .offset(x: goalModel.addStepViewOffset)
        }
    }
    
    
    private struct AddView: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @StateObject private var viewModel = AddStepModel()
        
        
        var body: some View {
            VStack(alignment: .trailing, spacing: 5) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 180, height: 175)
                    .foregroundColor(goalModel.selectedGoal.color.get(.light))
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 90, height: 90)
                    .foregroundColor(goalModel.selectedGoal.color.get(.light))
            }
            .padding(.horizontal, Layout.firstLayerPadding)
        }
    }
}


extension VerticalAlignment {
    
    enum AddStepAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    
    static let addStepAlignment = Self(AddStepAlignment.self)
}
