//
//  BartenderProvider.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import Foundation
import UIKit
enum BartenderError: Error {
    case noDataAvailable
    case canNotProcessData
}
//enum Result<T> {
//    case Success(T)
//    case Error(String)
//}

class BartenderProvider {
    
    var chosenCategory:String?
    var userQuery: String?
    var cocktailID: String?
    var favDrinkId = [BartenderDrinks]()
    var drinksFav = [DrinkDetail]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchAllBratenderAPI(completion: @escaping (Result<[DrinkDetail], BartenderError>) -> Void){
        
        let yourString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\((userQuery) ?? "")"
        let urlNew:String = yourString.replacingOccurrences(of: " ", with: "+").trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: urlNew)!
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = sharedSession.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let BDecoder = JSONDecoder()
                let bartenderData = try BDecoder.decode(CocktailResponse.self, from: jsonData)
                let bartenderDetail = bartenderData.drinks
                //print(bartenderDetail)
                completion(.success(bartenderDetail))
                // completion(.success(bartenderData))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
        //        }
    }
    
    func fetchCategoryAPI(completion: @escaping (Result<[CategoryDetails], BartenderError>) -> Void){
        
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = sharedSession.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let BDecoder = JSONDecoder()
                let categoryData = try BDecoder.decode(CategoryResponse.self, from: jsonData)
                let categoryDetail = categoryData.catedrinks
                completion(.success(categoryDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    func fetchAPI(completion: @escaping (Result<[DrinkDetail], BartenderError>) -> Void){
        
        var url:URL?
        let yourString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\((chosenCategory)!)"
        let urlNew:String = yourString.replacingOccurrences(of: " ", with: "_").trimmingCharacters(in: .whitespacesAndNewlines)
        print("This is your link: \(urlNew)")
        url = URL(string: urlNew)!
        
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url!)
        
        let task = sharedSession.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let BDecoder = JSONDecoder()
                let categoryData = try BDecoder.decode(CocktailResponse.self, from: jsonData)
                let categoryDetail = categoryData.drinks
                completion(.success(categoryDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    func fetchFavouritesDetail(completion: @escaping (Result<[DrinkDetail], BartenderError>) -> Void){
        
        let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\((cocktailID) ?? "")"
        let url = URL(string: queryURL)!
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = sharedSession.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let BDecoder = JSONDecoder()
                let categoryData = try BDecoder.decode(CocktailResponse.self, from: jsonData)
                let categoryDetail = categoryData.drinks
                completion(.success(categoryDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    
    
    func fetchFavourites(completion: @escaping (Result<[DrinkDetail], BartenderError>) -> Void){
        print("fetching favour \(favDrinkId.count)")
        for i in 0..<favDrinkId.count {
            let items = favDrinkId[i].drinkId as String?
            let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(items!)"
            let url = URL(string: queryURL)!
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)
            let task = urlSession.dataTask(with: urlRequest){ data, _, _ in
                
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do{
                    let BDecoder = JSONDecoder()
                    let categoryData = try BDecoder.decode(CocktailResponse.self, from: jsonData).drinks
                    self.drinksFav.append(contentsOf: categoryData)
                    DispatchQueue.main.async {
                        
                        completion(.success(categoryData))
                        print("Favourites download")
                    }
                    
                } catch {
                    print("fail to download")
                    completion(.failure(.canNotProcessData))
                }
                
            }
            task.resume()
        }
    }
    
    
}


//class Bar {

//}
