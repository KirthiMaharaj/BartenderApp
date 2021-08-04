//
//  CategoryModel.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/02.
//

import Foundation

struct BartenderResponse: Decodable {
    let barDrink: [BartenderDetails]
    
    enum CodingKeys: String, CodingKey {
        case barDrink = "drinks"
    }
}

struct BartenderDetails: Decodable {
    let drinksId:String
    let strDrink:String
    let strDrinkThumb:String
    
    enum CodingKeys: String, CodingKey {
        case drinksId = "idDrink"
        case strDrink, strDrinkThumb
    }
}
