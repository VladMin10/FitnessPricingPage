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
    @State private var selectedSubscriptionType: String = "monthly"
    @State private var expandedFAQ: UUID? = nil
    @State private var showingRestoreInfo = false
    
    var body: some View {
        ZStack {
            backgroundLayer
            ScrollView {
                VStack {
                    headerView
                    subtitleView
                    planButton
                        .padding(.horizontal)
                    subscriptionOptionsView
                        .padding(.top)
                        .padding(.horizontal)
                    subscribeButton
                        .padding(.vertical)
                    secondTitleView
                        .padding(.top)
                    UniversityCarouselView()
                        .padding(.trailing)
                        .padding(.bottom)
                    secondSubtitleView
                        .padding(.top)
                    bulletsView
                        .padding(.top)
                    thirdSection
                        .padding(.top, 40)
                    FeedbackCarouselView()
                    faqSection
                       // .padding(.top, 40)
                    supportSection
                        .padding(.top, 40)
                        .padding(.bottom, 20)
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
                .padding(.horizontal)
            }
        }
    }
    
    private var subtitleView: some View {
        Text("Find the best plan for your needs and get started!")
            .foregroundStyle(Color.theme.accent)
            .font(.system(size: 20, weight: .light))
            .frame(maxWidth : .infinity, alignment: .leading)
            .padding(.leading, 5)
            .padding(.horizontal)
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
                    Text(selectedPlan == "indi" ? data.subtitle.indi + ".":
                            selectedPlan == "pro" ? data.subtitle.pro + ".":
                            data.subtitle.business + ".")
                        .foregroundColor(Color.theme.accent)
                }
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .frame(maxWidth : .infinity, alignment: .leading)
              
            }
        }
    }
    private var subscriptionOptionsView: some View {
        VStack(spacing: 12) {
            if let data = selectedLanguage {
                VStack(spacing: 15) {
                    let subscriptions = selectedPlan == "indi" ? data.subscriptions.indi :
                                        selectedPlan == "pro" ? data.subscriptions.pro :
                                        data.subscriptions.business
                    
                    // Відображаємо підписку "3 Month", якщо вона є
                    if selectedPlan == "indi", let threeMonthSubscription = subscriptions.threeMonth {
                        subscriptionOption(
                            type: "3month",
                            title: threeMonthSubscription.title,
                            price: "$45",
                            billing: "USD/" + threeMonthSubscription.billing,
                            regularPrice: data.secondaryText,
                            monthBreakdown: "$15",
                            monthText: data.valueMonthBreakdownText
                        )
                    }
                    
                    // Опція місячної підписки
                    subscriptionOption(
                        type: "monthly",
                        title: subscriptions.monthly.title,
                        price: "$15",
                        billing: "USD/" + subscriptions.monthly.billing,
                        regularPrice: data.secondaryText
                    )
                    
                    // Опція річної підписки
                    subscriptionOption(
                        type: "yearly",
                        title: subscriptions.yearly.title,
                        price: "$89",
                        billing: "USD/" + subscriptions.yearly.billing,
                        regularPrice: data.secondaryText,
                        monthBreakdown: "$7.42",
                        monthText: data.valueMonthBreakdownText,
                        savings: subscriptions.yearly.discount ?? "",
                        savingsText: data.valueSavingText,
                        discount: data.discountText + " " + (subscriptions.yearly.discount ?? "") + "%"
                    )
                }
            }
        }
    }

    // End of file. No additional code necessary.

    private func subscriptionOption(
        type: String,
        title: String,
        price: String,
        billing: String,
        regularPrice: String,
        monthBreakdown: String? = nil,
        monthText: String? = nil,
        savings: String? = nil,
        savingsText: String? = nil,
        discount: String? = nil
    ) -> some View {
        Button {
            selectedSubscriptionType = type
        } label: {
            ZStack(alignment: .topTrailing) {
                
                VStack {
                    // Main content
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(Color.theme.accent)
                            
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text(price)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.theme.accent)
                                
                                Text(billing)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                if let monthBreakdown = monthBreakdown,
                                   let monthText = monthText {
                                    Text("(\(monthBreakdown)/\(monthText))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                Spacer()
                                    // Savings text at bottom
                                if let savings = savings,
                                    let savingsText = savingsText {
                                    HStack() {
                                        Text("\(savingsText) $\(savings)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        }
                                   
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                
                // Discount label in top right
                if let discount = discount {
                    Text(discount)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.theme.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(8)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(selectedSubscriptionType == type ? Color.theme.orange : Color.gray.opacity(0.3))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }


        private var subscribeButton: some View {
            VStack(spacing: 8) {
                if let data = selectedLanguage {
                    Button {
                        // Handle subscription
                    } label: {
                        Text(data.iapButton)
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.theme.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Text(data.iapButtonTextBelow)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }

    private var secondTitleView: some View {
        Text("Over 300 universities teach with our apps!")
            .foregroundColor(Color.theme.accent)
            .bold()
            .multilineTextAlignment(.center)
            .font(.system(size: 32, weight: .semibold))
            .padding(.bottom)
            //.frame(maxWidth : .infinity, alignment: .leading)
            .padding(.leading, 5)
    }
    private var secondSubtitleView: some View {
        VStack(spacing : 5) {
            Text("At any plan you choose")
                .font(.system(size: 22, weight: .bold))
            Text("Individual, Pro and Business")
                .font(.system(size: 18, weight: .light))
        }
        .foregroundStyle(Color.theme.accent)
        .frame(maxWidth : .infinity, alignment: .center)
        .padding(.leading, 5)
    }

    private var bulletsView: some View {
        VStack(spacing: 16) {
            if let data = selectedLanguage {
                let bullets = selectedPlan == "indi" ? data.bullets.indi :
                selectedPlan == "pro" ? data.bullets.pro :
                data.bullets.business
                
                ForEach(Array(bullets.values.sorted()), id: \.self) { bullet in
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.theme.orange)
                            .font(.title3)
                        
                        Text(bullet)
                            .font(.system(size: 18))
                            .foregroundColor(Color.theme.accent)
                            .lineLimit(2)
                        
                        Spacer()
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.theme.switchBackround)
                    )
                }
            }
        }
        .padding(.horizontal)
    }


    private var thirdSection: some View {
        VStack(spacing: 24) {
            Text("Trusted by millions\nof users worldwide")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.accent)
            
            VStack(spacing: 20) {
                statView(value: "8M+", description: "Social media followers")
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 240, height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                    Spacer()
                }
                statView(value: "129", description: "Countries around the world")
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 240, height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                    Spacer()
                }
                statView(value: "100K+", description: "App stores reviews")
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 240, height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                    Spacer()
                }
                statView(value: "1200+", description: "Exercises 3D animations")
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(Color.theme.purple)
    }

    private func statView(value: String, description: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.theme.orange)
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(Color.theme.accent)
        }
    }

    private var faqSection: some View {
            VStack(spacing: 24) {
                Text("Frequently asked \nquestions")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.theme.accent)
                
                VStack(spacing: 22) {
                    ForEach(faqs) { faq in
                        Button {
                            withAnimation {
                                expandedFAQ = expandedFAQ == faq.id ? nil : faq.id
                            }
                        } label: {
                            HStack {
                                Text(faq.question)
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.theme.accent)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.theme.accent)
                                    .rotationEffect(.degrees(expandedFAQ == faq.id ? 90 : 0))
                            }
                            .padding(20)
                            .background(Color.theme.switchBackround)
                            .cornerRadius(6)
                        }
                        
                        if expandedFAQ == faq.id {
                            Text(faq.answer)
                                .font(.system(size: 14))
                                .foregroundColor(Color.theme.accent.opacity(0.8))
                                .padding(.horizontal)
                                .transition(.opacity)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        
        private var supportSection: some View {
            VStack(spacing: 16) {
                Text("Still have questions? Get in touch with \nour ")
                    .font(.system(size: 18))
                    .foregroundColor(Color.theme.accent) +
                Text("sales team.")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.theme.accent)
                    .underline()
                
                VStack(spacing: 8) {
                            Text("Restore Apple Subscription")
                                .font(.system(size: 16))
                                .foregroundColor(Color.theme.orange)
                                .underline()
                                .onTapGesture {
                                    showingRestoreInfo.toggle()
                                }
                            
                            if showingRestoreInfo {
                                Text("To restore your subscription, please ensure you are logged in to the App Store with the Apple ID used for the original purchase. Then use the \"Restore Subscription\" option on any iOS device.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.theme.accent)
                                    .padding(16)
                                    .background(Color.theme.switchBackround)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.theme.orange, lineWidth: 1)
                                        )
                                    .cornerRadius(6)
                                    .padding(.horizontal)
                            }
                        }

            }
            .multilineTextAlignment(.center)
        }
        
        private var restoreInfoOverlay: some View {
            ZStack {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingRestoreInfo = false
                    }
                
                VStack {
                    Text("To restore your subscription, please ensure you are logged in to the App Store with the Apple ID used for the original purchase. Then use the \"Restore Subscription\" option on any iOS device.")
                        .font(.system(size: 14))
                        .foregroundColor(Color.theme.accent)
                        .padding(16)
                        .background(Color.theme.switchBackround)
                        .cornerRadius(6)
                        
                        .padding(.horizontal, 32)
                }
            }
        }


}

#Preview {
    PricingPageView()
}
