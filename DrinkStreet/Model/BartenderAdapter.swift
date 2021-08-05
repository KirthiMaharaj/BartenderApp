//
//  BartenderAdapter.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/04.
//

import Foundation
import KRActivityIndicatorView

protocol BartenderAdaptersProtocol {
    func getAllBartender() -> ()
}

class BartenderAdapter: BartenderAdaptersProtocol {
    
    let activityIndicator = KRActivityIndicatorView(colors: [.green])
    let bartenderProvider = BartenderProvider()
    var drinkDetail = [DrinkDetail]() {
        didSet{
            DispatchQueue.main.async { [self] in
                activityIndicator.animating = true
                activityIndicator.startAnimating()
//                self.tableView.reloadData()
//                self.navigationItem.title = "21 Drink Street"
                
            }
        }
    }

    internal func getAllBartender() {
        bartenderProvider.fetchAllBratenderAPI { [weak self] allDetail in
            switch allDetail {
            case .success(let drinksDetail):
                DispatchQueue.main.async {
                    self?.drinkDetail = drinksDetail
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDrinkDetails(){
        getAllBartender()
    }
    
    
}
