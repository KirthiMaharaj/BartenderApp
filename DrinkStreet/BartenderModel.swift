//
//  BartenderModel.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import Foundation

struct CocktailResponse: Decodable {
    let drinks: [DrinkDetail]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}

struct DrinkDetail: Decodable {
    let drinksId:String
    let strDrink:String
    let strCategory:String
    let strAlcoholic:String
    let strInstructions:String
    let strDrinkThumb:String
    /*
    let strIngredient1:String
    let strIngredient2:String
    let strIngredient3:String
    let strIngredient4:String
    let strIngredient5:String
 */
    
    enum CodingKeys: String, CodingKey {
        case drinksId = "idDrink"
        case strDrink, strCategory, strAlcoholic, strInstructions, strDrinkThumb
    }
}
