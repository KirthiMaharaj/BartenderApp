//
//  CategoryTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/27.
//

import UIKit
import ProgressHUD

class CategoryTableViewController: UITableViewController {
    
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.45)
        ProgressHUD.show()
        self.bindViewModel()
        self.bartenderAdapter.getCategory()
    }
    
    fileprivate func bindViewModel() {
        self.bartenderAdapter.delegate2 = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return bartenderAdapter.drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        // Configure the cell...
        
        cell.categoryLabel.text = bartenderAdapter.drinkDetail[indexPath.row].strCategory
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is BartenderCategoryTableView {
            BartenderAdapter.chosenCategory = bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!].strCategory
//            destination.bartenderAdapter.categoryDetail = bartenderAdapter.categoryDetail
//            BartenderAdapter.chosenCategory = bartenderAdapter.categoryDetail[(tableView.indexPathForSelectedRow?.row)!].strCategory
        }
    }
}

extension CategoryTableViewController: BartenderAdaptersProtocol2 {
    func getCategory() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = "21 Drink Street"
        }
    } 
}
