//
//  Model.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 06.03.2025.
//

import Foundation

// Модель для одного плану підписки
struct SubscriptionPlan: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let clientsLimit: Int
    let pricing: [SubscriptionPrice]
}

// Модель для ціни підписки
struct SubscriptionPrice: Codable, Identifiable {
    let id: String
    let type: String // "monthly", "yearly"
    let price: Double
    let discount: Double? // Наприклад, 50% знижки
}

// Add these models for JSON structure
struct LocalizationData: Codable {
    let en, de, es, ru, pt, ko: LanguageData
}

struct LanguageData: Codable {
    let planToggleButton: PlanToggleButton
    let title: TitleData
    let subtitle: SubtitleData
    let bullets: BulletsData
    let iapButton: String
    let iapButtonTextBelow: String
    let subscriptions: SubscriptionsData
    let secondaryText: String
    let valueMonthBreakdownText: String
    let valueSavingText: String
    let discountText: String
}

struct PlanToggleButton: Codable {
    let indi, pro, business: String
}

struct TitleData: Codable {
    let indi, pro, business: String
}

struct SubtitleData: Codable {
    let indi, pro, business: String
}

struct BulletsData: Codable {
    let indi, pro, business: [String: String]
}

struct SubscriptionsData: Codable {
    let indi, pro, business: PlanSubscriptionOptions
}

struct PlanSubscriptionOptions: Codable {
    let monthly, yearly: SubscriptionDetails
}

struct SubscriptionDetails: Codable {
    let title, billing: String
    let valueMonthBreakdownDividePriceBy: String?
    let valueSavingsMultiplePriceBy: String?
    let discount: String?
    let iapIdIos, iapIdAndroid: String?
}

// Function to load JSON data
func loadLocalizationData() -> LocalizationData? {
    guard let url = Bundle.main.url(forResource: "iapScreen", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Error: JSON file not found!")
        return nil
    }

    do {
        return try JSONDecoder().decode(LocalizationData.self, from: data)
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}
