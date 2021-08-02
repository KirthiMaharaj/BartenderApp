//
//  BartenderCategoryTableView.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/30.
//

import UIKit

class BartenderCategoryTableView: UITableViewController {
    
    
    
    let bartenderProvider = BartenderProvider()
    var drinkDetail = [DrinkDetail]() {
        didSet{
            DispatchQueue.main.async { [self] in
                self.tableView.reloadData()
            }
        }
    }
    //var categoryDetail: [CategoryDetails]?
    var categoryDetail = [CategoryDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBartenderCategory()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    fileprivate func getBartenderCategory() {
        bartenderProvider.fetchBratenderAPI { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinkDetail = drinks
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BartenderCategoryCell", for: indexPath) as! BartenderCategoryCell
        
        // Configure the cell...
        let categorydrink = drinkDetail[indexPath.row]
        //let filteredArray = self.categoryDetail?.filter({($0.strCategory == "\(categorydrink.strCategory)")})
        for categey in categoryDetail {
            if categorydrink.strCategory == categey.strCategory {
                cell.drinkName.text = "\(categorydrink.strDrink)"
                let url = URL(string: "\(categorydrink.strDrinkThumb)")
                if let dataImage = try? Data(contentsOf: url!){
                    cell.drinkImageView.image = UIImage(data: dataImage)
                }
            }
        }
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BartenderDetailViewController {
            destination.drinkDetail = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    
    
}
