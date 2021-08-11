//
//  CategoryTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/27.
//

import UIKit
import ProgressHUD

class CategoryTableViewController: UITableViewController {
    
    //    let bartenderProvider = BartenderProvider()
    //    var categoryDetail = [CategoryDetails]() {
    //        didSet{
    //            DispatchQueue.main.async { [self] in
    //                activityIndicator.startAnimating()
    //                self.tableView.reloadData()
    //                self.navigationItem.title = "21 Drink Street"
    //            }
    //        }
    //    }
    //    var category = [DrinkDetail]()
    //
    //        var drinkDetail = [DrinkDetail]() {
    //            didSet{
    //                DispatchQueue.main.async { [self] in
    //                    self.tableView.reloadData()
    //                    self.navigationItem.title = "21 Drink Street"
    //
    //                }
    //            }
    //        }
    //    let activityIndicator = KRActivityIndicatorView(colors: [.green])
    
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.45)
        ProgressHUD.show()
        view.addSubview(bartenderAdapter.activityIndicator)
        bartenderAdapter.activityIndicator.frame(forAlignmentRect: .infinite)
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
        //return drinkDetail.count
        return bartenderAdapter.categoryDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        // Configure the cell...
        //        let category = categoryDetail[indexPath.row]
        cell.categoryLabel.text = bartenderAdapter.categoryDetail[indexPath.row].strCategory
        
        return cell
    }
    
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        performSegue(withIdentifier: "SendDataSegue", sender: self)
    //    }
    
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
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BartenderCategoryTableView {
            // destination.drinkDetail = categoryDetail[(tableView.indexPathForSelectedRow?.row)!]
            destination.bartenderAdapter.categoryDetail = bartenderAdapter.categoryDetail
            BartenderAdapter.chosenCategory = bartenderAdapter.categoryDetail[(tableView.indexPathForSelectedRow?.row)!].strCategory
            // destination.categoryDetail = categoryDetail[(tableView.indexPathForSelectedRow?.row)!]
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
