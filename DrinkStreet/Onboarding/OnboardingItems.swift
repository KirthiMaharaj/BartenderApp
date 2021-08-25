//
//  OnboardingItems.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/24.
//

import Foundation
import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let image: UIImage?
    
    static let placeHolderItems: [OnboardingItem] = [
        .init(title: "Welcome To 21 Drink Street",
              detail: "Welcome to our bartender App 21 Drink Street",
              image: UIImage(named: "3")),
        .init(title: "Drinks Types",
              detail: "We have an varity of drinks. Our drinks are non-alcoholic and alcoholic.",
              image: UIImage(named: "4")),
        .init(title: "About App",
              detail: "This app is about finding your perfect drink. That have different category with ingredient and instructions so that you can make it.",
              image: UIImage(named: "5")),
        
    ]
}
