//
//  FavouriteViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/26.
//

import UIKit
import ProgressHUD
class FavouriteViewController: UITableViewController {
    var bar: DrinkDetail!
    let bartenderAdapter = BartenderAdapter()
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.45)
        ProgressHUD.show()
        tableView.addSubview( bartenderAdapter.activityIndicator)
        bartenderAdapter.activityIndicator.frame(forAlignmentRect: .infinite)
        self.bindViewModel()
        bartenderAdapter.getAllBartender()
        //        getFav()
    }
    
    
//    var favlist = [Int:Bool]()
//    let tempList = [Int]()
//    private func getFav(){
//        for i in 0...bartenderAdapter.drinkDetail.count {
//            if favlist[i] == true {
//                bartenderAdapter.list.append(i)
//            }
//        }
//    }
    
    fileprivate func bindViewModel() {
        self.bartenderAdapter.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bartenderAdapter.list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell
        
        
        cell.favButton.tag = indexPath.row
        cell.favName.text = bartenderAdapter.drinkDetail[bartenderAdapter.list[indexPath.row]].strDrink
        let url = URL(string: "\((bartenderAdapter.drinkDetail[bartenderAdapter.list[indexPath.row]].strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            cell.favImageView.image = UIImage(data: dataImage)
        }
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bartenderAdapter.details = bartenderAdapter.drinkDetail[indexPath.row]
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
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //        if segue.identifier == "Favourites"{
    //            let dd = segue.destination as! BartenderTableViewController
    //            let cell = sender as! BartenderListCell
    //            dd.bartenderAdapter.drinkDetail[cell.tag] = bartenderAdapter.drinkDetail[cell.tag]
    //        }
    //    }
}

extension FavouriteViewController: BartenderAdaptersProtocol {
    static var userQuery: String?
    
    func getAllBartender() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
