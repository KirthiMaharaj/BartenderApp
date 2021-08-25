//
//  FavouriteViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/26.
//

import UIKit

class FavouriteViewController: UITableViewController {
    
    let bartenderAdapter = BartenderAdapter()
  var bar = BartenderProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
       // getCDCocktails()
        bartenderAdapter.drinkDetail.removeAll()
         self.bindDrinkModel()
        bartenderAdapter.getCDCocktails()
        bartenderAdapter.getFavouritesDrink()
        print("This is favourite \( bartenderAdapter.drinkDetail.count)")
    }
        fileprivate func bindDrinkModel() {
            self.bartenderAdapter.delegate5 = self
        }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bartenderAdapter.drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell
        let favouriteDrinks = bartenderAdapter.drinkDetail[indexPath.row]
        // Configure the cell...
        // cell.configure(withInfo: favouriteDrinks)
        cell.favName.text = favouriteDrinks.strDrink
        cell.favCategory.text = favouriteDrinks.strCategory
        let url = URL(string: "\((favouriteDrinks.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            cell.favImageView.image = UIImage(data: dataImage)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bartenderAdapter.details = bartenderAdapter.drinkDetail[indexPath.row]
        let destination = storyboard?.instantiateViewController(identifier: "BartenderDetailViewController") as? BartenderDetailViewController
        destination!.bartenderAdapter.bartenderProvider.cocktailID = bartenderAdapter.drinkDetail[indexPath.row].drinksId
        self.navigationController?.pushViewController(destination!, animated: true)
    }
    
//    func getCDCocktails() {
//        do {
//            bartenderAdapter.models = try bartenderAdapter.context.fetch(BartenderDrinks.fetchRequest())
//        } catch {
//            print("Error Getting items: \(error.localizedDescription)")
//        }
//    }
    // MARK: - Navigation
    
    //  In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //        let destination = storyboard?.instantiateViewController(identifier: "BartenderDetailViewController") as? BartenderDetailViewController
    //        destination!.bartenderAdapter.bartenderProvider.cocktailID = bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!].drinksId
    //        self.navigationController?.pushViewController(destination!, animated: true)
    //
    //    }
}

extension FavouriteViewController: BartenderAdaptersProtocol, BartenderAdaptersProtocol5 { //BartenderAdaptersProtocol,
    func getFavouritesDrink() {
       // getCDCocktails()
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
