//
//  bartenderAdapter.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/28.
//

import Foundation


class BartenderAdapter {
    let bartenderProvider = BartenderProvider()
    var categoryDetail = [CategoryDetails]() {
        didSet{
            DispatchQueue.main.async { [self] in
                activityIndicator.startAnimating()
                self.tableView.reloadData()
                self.navigationItem.title = "21 Drink Street"
            }
        }
    }
    fileprivate func getCategory() {
        bartenderProvider.fetchCategoryAPI { [weak self] result in
            switch result {
            case .success(let category):
                self?.categoryDetail = category
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
