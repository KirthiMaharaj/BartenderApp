//
//  FavouriteViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/26.
//

import UIKit

class FavouriteViewController: UITableViewController {
    
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
        bartenderAdapter.getFavouritesDrink()
    }
    
    

    
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
        return bartenderAdapter.drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell

        // Configure the cell...
        cell.configure(withInfo: bartenderAdapter.drinkDetail[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // bartenderAdapter.details = bartenderAdapter.drinkDetail[indexPath.row]
        let destination = storyboard?.instantiateViewController(identifier: "BartenderDetailViewController") as? BartenderDetailViewController
        destination!.bartenderAdapter.bartenderProvider.cocktailID = bartenderAdapter.drinkDetail[indexPath.row].drinksId
        self.navigationController?.pushViewController(destination!, animated: true)
    }
    
    func getCDCocktails() {
        do {
            bartenderAdapter.models = try bartenderAdapter.context.fetch(BartenderDrinks.fetchRequest())
        } catch {
            print("Error Getting items: \(error.localizedDescription)")
        }
    }
    // MARK: - Navigation
    
   //  In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            let destination = storyboard?.instantiateViewController(identifier: "BartenderDetailViewController") as? BartenderDetailViewController
            destination!.bartenderAdapter.bartenderProvider.cocktailID = bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!].drinksId
            self.navigationController?.pushViewController(destination!, animated: true)
           
        }
}

extension FavouriteViewController: BartenderAdaptersProtocol, BartenderAdaptersProtocol5 {
    func getFavouritesDrink() {
        getCDCocktails()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    static var userQuery: String?
    
    func getAllBartender() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
