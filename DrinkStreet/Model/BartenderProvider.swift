//
//  BartenderProvider.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import Foundation

enum BartenderError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct BartenderProvider {
    func fetchBratenderAPI(completion: @escaping (Result<[DrinkDetail], BartenderError>) -> Void){
        
        // guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a&f=b&f=c") else {return}
        //let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a")!
        let url = "https://www.thecocktaildb.com/api/json/v1/1"
        let searchPath = "search.php"
        let quaryParam = "f"
        let sharedSession = URLSession.shared
        let details = "abcdefghijklmnopqrstuvwxyz".compactMap { $0 }
        for bartender in details {
            let urls = URL(string: "\(url)/\(searchPath)?\(quaryParam)=\(bartender)")!
            print("\(url)/\(searchPath)?\(quaryParam)=\(bartender)")
            let request = URLRequest(url: urls)
            
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
        }
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
}
