//
//  BartenderAdapter.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/04.
//

import Foundation
import ProgressHUD
import CoreData
import UIKit

protocol BartenderAdaptersProtocol: AnyObject {
    func getAllBartender()
    static var userQuery: String? { get  }
}

protocol BartenderAdaptersProtocol2: AnyObject {
    func getCategory()
}

protocol BartenderAdaptersProtocol3: AnyObject {
    static var chosenCategory: String? { get }
    func getBartenderCategory()
}

protocol BartenderAdaptersProtocol4 {
    func getFavourites()
    static var cocktailID: String? { get }
}
protocol BartenderAdaptersProtocol5 {
    func getFavouritesDrink()
    
}
class BartenderAdapter: BartenderAdaptersProtocol, BartenderAdaptersProtocol2, BartenderAdaptersProtocol3, BartenderAdaptersProtocol4, BartenderAdaptersProtocol5{
    
    
    static var cocktailID: String?
    static var chosenCategory: String?
    static var userQuery: String?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var models = [BartenderDrinks]()
    var favDrinkId = [BartenderDrinks]()
    var favId: BartenderDrinks?
    weak var delegate: BartenderAdaptersProtocol?
    weak var delegate2: BartenderAdaptersProtocol2?
    weak var delegate3: BartenderAdaptersProtocol3?
    var delegate4: BartenderAdaptersProtocol4?
    var delegate5: BartenderAdaptersProtocol5?
    var bartenderProvider = BartenderProvider()
    var drinkDetail: [DrinkDetail] = []
    var categoryDetail: [CategoryDetails] = []
    var details: DrinkDetail?
    
    // All drinks
    func getAllBartender() {
        self.delegate?.getAllBartender()
        bartenderProvider.userQuery = BartenderAdapter.userQuery
        bartenderProvider.fetchAllBratenderAPI { [weak self] allDetail in
            switch allDetail {
            case .success(let drinksDetail):
                self?.drinkDetail = drinksDetail
                self?.delegate?.getAllBartender()
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                }
            case .failure(let error):
                ProgressHUD.showFailed()
                print("API Fetching error: \(error)")
            }
        }
    }
    
    // Different type of Category for the Drink
    func getCategory() {
        self.delegate2?.getCategory()
        bartenderProvider.fetchCategoryAPI { [weak self] result in
            switch result {
            case .success(let category):
                self?.categoryDetail = category
                self?.delegate2?.getCategory()
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                }
            case .failure(let error):
                ProgressHUD.showFailed()
                print("API Fetching error: \(error)")
            }
        }
    }
    
    // Select drinks for the Category
    func getBartenderCategory() {
        self.delegate3?.getBartenderCategory()
        bartenderProvider.chosenCategory = BartenderAdapter.chosenCategory!
        bartenderProvider.fetchAPI { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinkDetail = drinks
                self?.delegate3?.getBartenderCategory()
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                }
            case .failure(let error):
                ProgressHUD.showFailed()
                print("API Fetching error: \(error)")
            }
        }
    }
    
    // Favourting the drinks
    func getFavourites() {
        self.delegate4 = self
        bartenderProvider.cocktailID = BartenderAdapter.cocktailID
        bartenderProvider.fetchFavouritesDetail { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drinkDetail = drink
                self?.details = drink[0]
            case .failure(let error):
                print("API Fetching error: \(error)")
            }
        }
    }
    func getCDCocktails()
    {
        
        do
        {
            favDrinkId = try context.fetch(BartenderDrinks.fetchRequest())
            
        }
        catch
        {
            print("Error Getting items: \(error.localizedDescription)")
        }
        print("This is count \(favDrinkId.count)")
    }
    // Showing the favourting Drinks
    func getFavouritesDrink() {
        self.delegate5 = self
        bartenderProvider.favDrinkId = favDrinkId
        //  bartenderProvider.favDrinkId = favId?.drinkId
        bartenderProvider.fetchFavourites { [weak self] result in
            switch result {
            case .success(let drinkD):
                self?.drinkDetail = drinkD
            case .failure(let error):
                print("API Fetching error: \(error)")
            }
        }
        
    }
//    
//    func favorites(atIndex: Int){
//        self.drinkDetail[atIndex].isFav = !self.drinkDetail[atIndex].isFav
//    }
    
}
