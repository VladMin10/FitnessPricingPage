//
//  PricingView.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 06.03.2025.
//

import SwiftUI

struct PricingView: View {
    @State private var localizationData: LocalizationData?
    @State private var selectedPlan: String = "indi"
    @State private var selectedLanguage: LanguageData?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let data = selectedLanguage {
                    // Plan Toggle Buttons
                    HStack(spacing: 15) {
                        PlanButton(title: data.planToggleButton.indi,
                                 isSelected: selectedPlan == "indi") {
                            selectedPlan = "indi"
                        }
                        PlanButton(title: data.planToggleButton.pro,
                                 isSelected: selectedPlan == "pro") {
                            selectedPlan = "pro"
                        }
                        PlanButton(title: data.planToggleButton.business,
                                 isSelected: selectedPlan == "business") {
                            selectedPlan = "business"
                        }
                    }
                    .padding()
                    
                    // Title
                    Text(selectedPlan == "indi" ? data.title.indi :
                         selectedPlan == "pro" ? data.title.pro :
                         data.title.business)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Subtitle
                    Text(selectedPlan == "indi" ? data.subtitle.indi :
                         selectedPlan == "pro" ? data.subtitle.pro :
                         data.subtitle.business)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
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
                    
                    // Subscription Options
                    let subscriptions = selectedPlan == "indi" ? data.subscriptions.indi :
                                      selectedPlan == "pro" ? data.subscriptions.pro :
                                      data.subscriptions.business
                    
                    VStack(spacing: 15) {
                        SubscriptionOptionView(option: subscriptions.monthly,
                                             period: "Monthly")
                        SubscriptionOptionView(option: subscriptions.yearly,
                                             period: "Yearly")
                    }
                    .padding()
                    
                    // Subscribe Button
                    Button(action: {}) {
                        Text(data.iapButton)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Text(data.iapButtonTextBelow)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
            if localizationData == nil {
                localizationData = loadLocalizationData()
                selectedLanguage = localizationData?.en
            }
        }
    }
}

struct PlanButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

struct SubscriptionOptionView: View {
    let option: SubscriptionDetails
    let period: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(period)
                .font(.headline)
            Text("Billed \(option.billing.lowercased())ly")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let discount = option.discount {
                Text("Save \(discount)%")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}

struct PricingView_Previews: PreviewProvider {
    static var previews: some View {
        PricingView()
    }
}
