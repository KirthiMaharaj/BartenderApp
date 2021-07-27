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
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a&f=b&f=c&f=d&f=e&f=f")!
        
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
    }
}
