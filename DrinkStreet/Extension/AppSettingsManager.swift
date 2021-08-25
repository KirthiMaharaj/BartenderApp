//
//  AppSettingsManager.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/24.
//

import Foundation
import UIKit

class AppSettingsManager {
    static let shared = AppSettingsManager()
    
    let settings = UserDefaults(suiteName: "Kirthi.DrinkStreet.saved.data")
}
