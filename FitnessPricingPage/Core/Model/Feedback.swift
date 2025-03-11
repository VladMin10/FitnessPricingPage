//
//  Feedback.swift
//  FitnessPricingPage
//
//  Created by Vladyslav Mi on 10.03.2025.
//
import Foundation

struct Feedback: Identifiable {
    let id = UUID()
    let quote: String
    let description: String
    let name: String
    let title: String
    let institution: String
    let imageName: String
}

let feedbacks = [
    Feedback(
        quote: "Muscle and Motion’s products are absolutely incredible!",
        description: "That visual was absolute magic for me! I just was using the app now and can’t believe the detail and depth.",
        name: "Michele Bond",
        title: "MS / Exercise Physiologist",
        institution: "University of Texas, Odessa",
        imageName: "michele"
    )

    ,Feedback(
        quote: "Thank you for this incredible learning and teaching tool!",
        description: "Our students find that the dynamic movement give them a more accurate understanding.",
        name: "Samia H. Rafeedie",
        title: "OTD, OTR/L, CBIS, Assistant Professor Clinical",
        institution: "USA",
        imageName: "samia"
    )

    , Feedback(
        quote: "I love to learn from Muscle and Motion.",
        description: "Your videos help me in understanding the biomechanics of exercise and how to avoid injury.",
        name: "Franco Moreno",
        title: "Medical Student",
        institution: "Argentina",
        imageName: "franco"
    )

    ,Feedback(
        quote: "It teaches you not just how to do exercises correctly but why.",
        description: "My review of the program is that it’s great for everyone, whether they are a fitness professional or learning to exercise!",
        name: "Alejandrino Trujillo",
        title: "Exercise Science Student",
        institution: "Pennsylvania, USA",
        imageName: "alejandrino"
    )

    , Feedback(
        quote: "They are the perfect tool to help clients understand.",
        description: "The perfect tool to help clients understand why they might be having pain after certain exercises.",
        name: "Kole-ena Hunter",
        title: "Physiotherapist",
        institution: "Australia",
        imageName: "kole-ena"
    )

    ,Feedback(
        quote: "I cannot even begin to tell you how valuable this software is to me.",
        description: "I can recommend specific massage to help my clients improve their athletic performance.",
        name: "Kelly Jacobus",
        title: "RMT",
        institution: "New Jersey, USA",
        imageName: "kelly"
    )

   , Feedback(
        quote: "Your videos are an excellent tool for me and my patients!",
        description: "Excellent tool for me and my patients, it helps all of us understand the proper motion of each muscle.",
        name: "Aliene Tam",
        title: "RMT",
        institution: "",
        imageName: "aliene"
    )

    , Feedback(
        quote: "Muscle & Motion videos and training library are one of the best resources I have found!",
        description: "Effectively demonstrate target muscles, synergists, and stabilizers.",
        name: "Russell Gray",
        title: "Master Physique Competitor",
        institution: "",
        imageName: "russell"
    )

    , Feedback(
        quote: "I find your videos very helpful in educating my athletes to avoid injury!",
        description: "I am an athletic trainer for a high school. I find your videos very helpful in educating my athletes.",
        name: "Miles Kilewer",
        title: "High School Athletic Trainer",
        institution: "",
        imageName: "miles"
    )

    , Feedback(
        quote: "When I understand concepts better I can explain and teach my players better!",
        description: "This user-friendly software provides an interdisciplinary view of human movement.",
        name: "Goran Jamicic",
        title: "Field Hockey Coach",
        institution: "",
        imageName: "goran"
    )

    , Feedback(
        quote: "An essential app for trainers and health professionals – wish I found it sooner!",
        description: "I’ve only recently started using this App and only wish I had found it sooner. It’s amazing!",
        name: "Robert Gonzalez",
        title: "Paramedic and Personal Trainer",
        institution: "",
        imageName: "robert"
    )

    , Feedback(
        quote: "This app actually gives me the confidence to work out.",
        description: "This has the best anatomy and motion animations I have ever seen. Very detailed. Really phenomenal work, guys.",
        name: "Andrew Riachi",
        title: "Paramedic and Personal Trainer",
        institution: "",
        imageName: "andrew"
    )

]
