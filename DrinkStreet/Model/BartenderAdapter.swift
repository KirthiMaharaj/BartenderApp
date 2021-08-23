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
    var models = [BartenderDrinks]()
    weak var delegate: BartenderAdaptersProtocol?
    weak var delegate2: BartenderAdaptersProtocol2?
    weak var delegate3: BartenderAdaptersProtocol3?
    var delegate4: BartenderAdaptersProtocol4?
    var bartenderProvider = BartenderProvider()
    var drinkDetail: [DrinkDetail] = []
    var categoryDetail: [CategoryDetails] = []
    var details: DrinkDetail?
    
    
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
    
    func getFavourites() {
        self.delegate4 = self
        bartenderProvider.cocktailID = BartenderAdapter.cocktailID
        bartenderProvider.fetchFavouritesDetail { [weak self] result in
           // self?.details = self?.drinkDetail[0]
            switch result {
            case .success(let drink):
                self?.drinkDetail = drink
                self?.details = drink[0]
            case .failure(let error):
                print("API Fetching error: \(error)")
            }
        }
    }
    
    func getFavouritesDrink() {
        bartenderProvider.fetchFavourites { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drinkDetail = drink
            case .failure(let error):
                print("API Fetching error: \(error)")
            }
        }
    }
    
    
    
    //    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    //
    //    private var bartenderDrink: BartenderDrinks?
    //    weak var managedObjectContext:CoreDataStack.sharedInstance.persistentContainer.viewContext
    //
    //    func getFetchedResultController() -> NSFetchedResultsController<NSFetchRequestResult> {
    //        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    //        return fetchedResultController
    //    }
    //
    //    func taskFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BartenderDrinks")
    //        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    //        fetchRequest.sortDescriptors = [sortDescriptor]
    //        return fetchRequest
    //    }
    
    func favorites(atIndex: Int){
        self.drinkDetail[atIndex].isFav = !self.drinkDetail[atIndex].isFav
    }
    
}
