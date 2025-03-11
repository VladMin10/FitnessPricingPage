//
//  FeedbackCard.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 11.03.2025.
//

import SwiftUI

struct FeedbackCard: View {
    let feedback: Feedback
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 16) {
                Text("\"\(feedback.quote)\"")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.theme.accent)
                    .lineSpacing(4)
                    .lineLimit(3)
                           
                Text("\"\(feedback.description)\"")
                    .font(.system(size: 16))
                    .foregroundColor(Color.theme.accent.opacity(0.8))
                    .lineSpacing(4)
                    .lineLimit(3)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                Image(feedback.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(feedback.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.theme.accent)
                    Text(feedback.title)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    if !feedback.institution.isEmpty {
                        Text(feedback.institution)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .frame(width: 260, height: 432)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.switchBackround)
        )
    }
}

#Preview {
    FeedbackCard(feedback: feedbacks[0])
}
