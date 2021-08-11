//
//  BartenderModel.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import Foundation


protocol Favourites {
    var isFav: Bool {get set}
}
protocol Favourited {
    func toggleFav(drinks: DrinkDetail)
}
struct CocktailResponse: Decodable {
    let drinks: [DrinkDetail]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}

struct DrinkDetail: Decodable, Favourites {
    
    let drinksId:String?
    let strDrink:String?
    var strCategory:String?
    let strAlcoholic:String?
    let strInstructions:String?
    let strDrinkThumb:String?
    let strIngredient1:String?
    let strIngredient2:String?
    let strIngredient3:String?
    let strIngredient4:String?
    let strIngredient5:String?
    let strIngredient6:String?
    let strIngredient7:String?
    var isFav:Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case drinksId = "idDrink"
        case strDrink, strCategory, strAlcoholic, strInstructions, strDrinkThumb, strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7
    }
   
}


struct CategoryResponse: Decodable {
    let catedrinks: [CategoryDetails]
    enum CodingKeys: String, CodingKey {
        case catedrinks = "drinks"
    }
}

struct CategoryDetails: Decodable {
    let strCategory:String
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
    
    
}
