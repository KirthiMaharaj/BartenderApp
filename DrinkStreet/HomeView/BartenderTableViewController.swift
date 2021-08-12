//
//  BartenderTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit
import ProgressHUD

class BartenderTableViewController: UITableViewController {
    
    let bartenderAdapter = BartenderAdapter()
    let myView = BartenderListCell()
    var favoritesDrinks = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.60)
        ProgressHUD.show()
        tableView.addSubview( bartenderAdapter.activityIndicator)
        bartenderAdapter.activityIndicator.frame(forAlignmentRect: .infinite)
        self.bindDrinkModel()
        self.bartenderAdapter.getAllBartender()
      
    }
    
    
    fileprivate func bindDrinkModel() {
        self.bartenderAdapter.delegate = self
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  bartenderAdapter.drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BartenderListCell", for: indexPath) as! BartenderListCell
        // Configure the cell..."reuseIdentifier"
        
        cell.favoriteButton.tag = indexPath.row
        if cell.isFav == true {
            cell.configure(withInfo: self.bartenderAdapter.drinkDetail[indexPath.row])
            
        }else{
            cell.configure(withInfo: self.bartenderAdapter.drinkDetail[indexPath.row])
            
        }
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BartenderListCell
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.setImage(UIImage(named: "ic_fav"), for: .normal)
        cell.isFav = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BartenderListCell
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.setImage(UIImage(named: "ic_un_fav"), for: .normal)
        cell.isFav = false
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
            destination.bartenderAdapter.details =  bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        }
        //        if let destination = segue.destination as? FavouriteViewController {
        //            //  destination.drinkDetail = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        //            //let cell = sender as! FavouriteViewCell
        //          //  destination.bartenderAdapter.details = bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        //            destination.bartenderAdapter.drinkDetail =  bartenderAdapter.drinkDetail
        //            self.navigationController?.pushViewController(destination, animated: true)
        //        }
    }
}

extension BartenderTableViewController: BartenderAdaptersProtocol {
    static var userQuery: String?
    func getAllBartender() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = "21 Drink Street"
        }
    }
}

extension BartenderTableViewController: Favourited{
    func toggleFav(didTapButton button: UIButton) {
        self.bartenderAdapter.favorites(atIndex: button.tag)
        self.tableView.reloadData()
    }
    
}
