//
//  BartenderAdapter.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/04.
//

import Foundation
import KRActivityIndicatorView
import ProgressHUD

protocol BartenderAdaptersProtocol: AnyObject {
    func getAllBartender()
    static var userQuery: String? { get  }
}

protocol BartenderAdaptersProtocol2: AnyObject {
    func getCategory()
}

protocol BartenderAdaptersProtocol3: AnyObject{
    static var chosenCategory: String? { get }
    func getBartenderCategory()
}
class BartenderAdapter: BartenderAdaptersProtocol, BartenderAdaptersProtocol2, BartenderAdaptersProtocol3 {
    
    static var chosenCategory: String?
    static var userQuery: String?
    weak var delegate: BartenderAdaptersProtocol?
    weak var delegate2: BartenderAdaptersProtocol2?
    weak var delegate3: BartenderAdaptersProtocol3?
    let activityIndicator = KRActivityIndicatorView(colors: [.green])
    var bartenderProvider = BartenderProvider()
    var drinkDetail: [DrinkDetail] = []
    var categoryDetail: [CategoryDetails] = []
    var details: DrinkDetail?
    var list = [Int]()
    
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
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
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
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
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
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
            case .failure(let error):
                ProgressHUD.showFailed()
                print("API Fetching error: \(error)")
            }
        }
    }
    
    func favorites(atIndex: Int){
        self.drinkDetail[atIndex].isFav = !self.drinkDetail[atIndex].isFav
    }
    
}



//  var descs = ["Welcome to our bartender App 21 Drink Street"," We have an varity of drinks. Our drinks are non-alcoholic and alcoholic","This app is about finding your perfect drink. That have different category with ingredient and instructions so that you can make it."]
