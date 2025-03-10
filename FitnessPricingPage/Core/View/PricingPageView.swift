//
//  PricingPageView.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 06.03.2025.
//

import SwiftUI

struct PricingPageView: View {
    
    @EnvironmentObject private var vm: PricingPageVM
    private let screen = UIScreen.main.bounds.width
    //private let plans = ["Individual", "Pro", "Business"]
    @State private var localizationData: LocalizationData?
    @State private var selectedPlan: String = "indi"
    @State private var selectedLanguage: LanguageData?
    @State private var selectedSubscriptionType: String = "yearly"
    
    var body: some View {
        ZStack {
            backgroundLayer
            ScrollView {
                VStack {
                    headerView
                    subtitleView
                    planButton
//                    planSelectorView
//                    selectedPlanInfoView
//                    pricingOptionsView
//                    subscribeButton
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
                   if localizationData == nil {
                       localizationData = loadLocalizationData()
                       selectedLanguage = localizationData?.en
                   }
               }
    }
    
    private var backgroundLayer: some View {
        Color.background
            .edgesIgnoringSafeArea(.all)
    }
    
    private var headerView: some View {
        VStack(alignment : .leading){
            if let data = selectedLanguage{
                Text(selectedPlan == "indi" ? data.title.indi :
                        selectedPlan == "pro" ? data.title.pro :
                        data.title.business)
                .foregroundColor(Color.theme.accent)
                .bold()
                .multilineTextAlignment(.leading)
                .font(.system(size: 38, weight: .semibold))
                .padding(.bottom)
                .frame(maxWidth : .infinity, alignment: .leading)
                .padding(.leading, 5)
            }
        }
    }
    
    private var subtitleView: some View {
        Text("Find the best plan for your needs and get started!")
            .foregroundStyle(Color.theme.accent)
            .font(.system(size: 20, weight: .light))
            .frame(maxWidth : .infinity, alignment: .leading)
            .padding(.leading, 5)
    }
    
    
    private func planSwitch(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .black : .gray)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(isSelected ? Color.theme.orange : Color.clear)
                )
        }
    }
    
    private var planButton : some View{
        VStack(spacing: 20) {
            if let data = selectedLanguage {
                // Plan Toggle Buttons
                HStack(spacing: 15) {
                    planSwitch(title: data.planToggleButton.indi,
                               isSelected: selectedPlan == "indi") {
                        selectedPlan = "indi"
                    }
                    planSwitch(title: data.planToggleButton.pro,
                               isSelected: selectedPlan == "pro") {
                        selectedPlan = "pro"
                    }
                    planSwitch(title: data.planToggleButton.business,
                               isSelected: selectedPlan == "business") {
                        selectedPlan = "business"
                    }
                }
                .padding(4)
                .background(Color.theme.switchBackround)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                //Name of plan
                VStack(alignment : .leading, spacing : 5){
                    Text(selectedPlan == "indi" ? data.planToggleButton.indi + " Plan:" :
                            selectedPlan == "pro" ? data.planToggleButton.pro + " Plan:"  :
                            data.planToggleButton.business + " Plan:")
                        .foregroundColor(Color.theme.orange)
                    Text(selectedPlan == "indi" ? data.subtitle.indi :
                            selectedPlan == "pro" ? data.subtitle.pro :
                            data.subtitle.business)
                        .foregroundColor(Color.theme.accent)
                }
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .frame(maxWidth : .infinity, alignment: .leading)
                
                // Bullets
                let bullets = selectedPlan == "indi" ? data.bullets.indi :
                selectedPlan == "pro" ? data.bullets.pro :
                data.bullets.business
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(bullets.values.sorted()), id: \.self) { bullet in
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text(bullet)
                                .font(.body)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    PricingPageView()
}
