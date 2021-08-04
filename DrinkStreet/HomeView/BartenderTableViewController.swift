//
//  BartenderTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit
import KRActivityIndicatorView


class BartenderTableViewController: UITableViewController {

    let bartenderProvider = BartenderProvider()
    var drinkDetail = [DrinkDetail]() {
        didSet{
            DispatchQueue.main.async { [self] in
                //activityIndicator.animating = true
                activityIndicator.startAnimating()
                self.tableView.reloadData()
                self.navigationItem.title = "21 Drink Street"
                
            }
        }
    }
    let activityIndicator = KRActivityIndicatorView(colors: [.green])
    // var favDrinks = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(activityIndicator)
        activityIndicator.frame(forAlignmentRect: .infinite)
        getBartender()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    /*
     private func notFav(){
     for i in 0...drinkDetail.count {
     favDrinks[i] = false
     }
     }
     */
    fileprivate func getBartender() {
        bartenderProvider.fetchBratenderAPI { [weak self] drink in
            switch drink{
            case .success(let drinks):
                self?.drinkDetail = drinks
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BartenderListCell", for: indexPath) as! BartenderListCell
        // Configure the cell..."reuseIdentifier"
        let barDetails = drinkDetail[indexPath.row]
        let url = URL(string: "\((barDetails.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            cell.drinkImage.image = UIImage(data: dataImage)
        }
        cell.drinkName?.text = barDetails.strDrink
        cell.drinkCategory?.text = barDetails.strCategory
        
        /*
         if favDrinks[indexPath.row] == true {
         cell.favoriteButton.backgroundImage(for: UIControl.S) = UIColor.red
         }
         */
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
        if let destination = segue.destination as? FavouriteViewController {
            //  destination.drinkDetail = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
            destination.drinkDetail = drinkDetail
        }
        /*
         if let favDestination = segue.destination as? FavouriteViewController {
         favDestination.drinkDetail = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
         }
         */
        
    }
    
    
}

