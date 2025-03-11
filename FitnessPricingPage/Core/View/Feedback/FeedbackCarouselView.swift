//
//  FeedbackCarouselView.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 10.03.2025.
//

import SwiftUI

struct FeedbackCarouselView: View {
    @State private var currentPage = 0
    
    var body: some View {
        VStack(spacing: 32) {
            Text("What our users say\nabout us")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    Text("4.8")
                        .font(.system(size: 36, weight: .bold))
                    Text("/5")
                        .font(.system(size: 24))
                }
                .foregroundColor(Color.theme.accent)
                
                VStack (spacing : 4){
                    HStack(spacing: 4) { 
                        ForEach(0..<5) { index in
                            Image(systemName: index < 4 ? "star.fill" : "star.leadinghalf.filled")
                                .foregroundColor(Color.theme.orange)
                        }
                    }
                    Text("100k+ app stores reviews")
                        .font(.subheadline)
                        .foregroundColor(Color.theme.accent)
                }
                
              
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(feedbacks) { feedback in
                        FeedbackCard(feedback: feedback)
                            .onAppear {
                                if let index = feedbacks.firstIndex(where: { $0.id == feedback.id }) {
                                    currentPage = index
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            // Page indicators
            HStack(spacing: 8) {
                ForEach(0..<feedbacks.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.theme.orange : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.vertical, 32)
    }
}

#Preview {
    FeedbackCarouselView()
        .background(Color.background)
}
