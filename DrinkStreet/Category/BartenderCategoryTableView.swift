//
//  BartenderCategoryTableView.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/30.
//

import UIKit
import ProgressHUD


class BartenderCategoryTableView: UITableViewController {
    
    let cate = CategoryTableViewController()
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.45)
        ProgressHUD.show()
        self.bindViewModel()
        bartenderAdapter.getBartenderCategory()
    }
    
    fileprivate func bindViewModel() {
        self.bartenderAdapter.delegate3 = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BartenderCategoryCell", for: indexPath) as! BartenderCategoryCell
        // Configure the cell...
        cell.drinkName.text = bartenderAdapter.drinkDetail[indexPath.row].strDrink
        let url = URL(string: "\((bartenderAdapter.drinkDetail[indexPath.row].strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            cell.drinkImageView.image = UIImage(data: dataImage)
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BartenderDetailViewController {
            destination.cocktailID = bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!].drinksId
        }
    }
}

extension BartenderCategoryTableView: BartenderAdaptersProtocol3 {
    static var chosenCategory: String?
    func getBartenderCategory() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = "21 Drink Street"
        }
    }
    
}
