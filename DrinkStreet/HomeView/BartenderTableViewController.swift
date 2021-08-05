//
//  BartenderTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

class BartenderTableViewController: UITableViewController {
    
    //    var bartenderProvider = BartenderProvider()
    //        var drinkDetail = [DrinkDetail]() {
    //            didSet{
    //                DispatchQueue.main.async { [self] in
    //                    //activityIndicator.animating = true
    //                    activityIndicator.startAnimating()
    //                    self.tableView.reloadData()
    //                    self.navigationItem.title = "21 Drink Street"
    //
    //                }
    //            }
    //        }
    //    let activityIndicator = KRActivityIndicatorView(colors: [.green])
    //    var favDrinks = [Int:Bool]()
    
    let bartenderAdapter = BartenderAdapter()
    let myView = BartenderListCell()
    //let bar = BartenderAdaptersProtocol
    // var userQuery: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview( bartenderAdapter.activityIndicator)
        bartenderAdapter.activityIndicator.frame(forAlignmentRect: .infinite)
        self.bindViewModel()
        self.bartenderAdapter.getAllBartender()
        
    }
    
    fileprivate func bindViewModel() {
        self.bartenderAdapter.delegate = self
    }
    private func updateLoader(isLoading: Bool) {
       // self.loadingContainerView.isHidden = !isLoading
        //@IBOutlet weak var barContainerView: UIView!
        self.myView.barContainerView?.isHidden = !isLoading
        self.tableView.isHidden = isLoading
    }
    
    /*
     private func notFav(){
     for i in 0...drinkDetail.count {
     favDrinks[i] = false
     }
     }
     */
    //  fileprivate func getAllBartender() {
    //        bartenderProvider.userQuery = userQuery
    //        bartenderProvider.fetchAllBratenderAPI { [weak self] allDetail in
    //            switch allDetail {
    //            case .success(let drinksDetail):
    //                self?.drinkDetail = drinksDetail
    //                DispatchQueue.main.async {
    //                    self?.activityIndicator.stopAnimating()
    //                    self?.activityIndicator.removeFromSuperview()
    //                }
    //            case .failure(let error):
    //                print("API Fetching error: \(error)")
    //            }
    //        }
    //    }
    
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
    
        //        cell.drinkName.text = bartenderAdapter.drinkDetail[indexPath.row].strDrink
        //        cell.drinkCategory.text = bartenderAdapter.drinkDetail[indexPath.row].strCategory
        //        let url = URL(string: "\((bartenderAdapter.drinkDetail[indexPath.row].strDrinkThumb)!)")
        //        if let dataImage = try? Data(contentsOf: url!){
        //            cell.drinkImage.image = UIImage(data: dataImage)
        //        }
        cell.favoriteButton.tag = indexPath.row
        cell.fav(withDetail: self.bartenderAdapter.drinkDetail[indexPath.row])
        cell.delegate = self
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
            destination.drinkDetail =  bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        }
        //        if let destination = segue.destination as? FavouriteViewController {
        //            //  destination.drinkDetail = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        //            destination.drinkDetail =  bartenderAdapter.drinkDetail
        //        }
    }
}

extension BartenderTableViewController: BartenderAdaptersProtocol {
    static var userQuery: String?
    func getAllBartender() {
        DispatchQueue.main.async {
            self.updateLoader(isLoading: false)
            self.tableView.reloadData()
            self.navigationItem.title = "21 Drink Street"
        }
    }
}
extension BartenderTableViewController: BartenderListCellDelegate {
    func didTapMakeFavourite(button: UIButton) {
        self.bartenderAdapter.favorites(atIndex: button.tag)
        self.tableView.reloadData()
    }
}
