//
//  FAQ.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 11.03.2025.
//
import Foundation

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    var isExpanded: Bool = false
    let answer: String
}

let faqs = [
    FAQ(question: "Question 1", answer: "Answer to question 1"),
    FAQ(question: "Question 2", answer: "Answer to question 2"),
    FAQ(question: "Question 3", answer: "Answer to question 3")
]
