//
//  Universities.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 10.03.2025.
//

import Foundation

struct University: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

let universities = [
    University(name: "ASU", imageName: "asu"),
    University(name: "Boston", imageName: "boston"),
    University(name: "Florida", imageName: "florida"),
    University(name: "Hartford", imageName: "hartford"),
    University(name: "Seattle", imageName: "seattle"),
    University(name: "Setton Hall", imageName: "settonhall"),
    University(name: "Utah", imageName: "utah"),
    University(name: "Utah2", imageName: "utah2")
]
