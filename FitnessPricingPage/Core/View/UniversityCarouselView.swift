//
//  UniversityCarouselView.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 10.03.2025.
//

import SwiftUI

// Your imports remain the same

struct UniversityCarouselView: View {
    private let screen = UIScreen.main.bounds.width
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(Array(universities.enumerated()), id: \.element.id) { index, university in
                        Image(university.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: (screen - 80) / 3)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .id(index)
                    }
                }
                .padding(.horizontal)
            }
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % universities.count
                    proxy.scrollTo(currentIndex, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    UniversityCarouselView()
}
