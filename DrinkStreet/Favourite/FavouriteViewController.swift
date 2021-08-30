//
//  FavouriteViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/26.
//

import UIKit

class FavouriteViewController: UITableViewController {
    
    
    var favDrinkId = [BartenderDrinks]()
    var drinkDetail = [DrinkDetail]()
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        drinkDetail.removeAll()
        self.tableView.reloadData()
        getCDCocktails()
        downloadCocktailDetaillsJSON {
            print("Attempting to download cocktails")
            self.tableView.reloadData()
            print("Done downloading cocktails")
        }
        tableView.dataSource =  self
        tableView.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell
        let favouriteDrinks = drinkDetail[indexPath.row]
        // Configure the cell...
        cell.favName.text = favouriteDrinks.strDrink
        cell.favCategory.text = favouriteDrinks.strCategory
        let url = URL(string: "\((favouriteDrinks.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            cell.favImageView.image = UIImage(data: dataImage)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BartenderDetailViewController {
      //  destination.cocktailID = drinkDetail[(tableView.indexPathForSelectedRow?.row)!].drinksId
        destination.bartenderAdapter.details = drinkDetail[(tableView.indexPathForSelectedRow?.row)!]

          //  BartenderDetailViewController.cocktailID = drinkDetail[(tableView.indexPathForSelectedRow?.row)!].drinksId

        }
        
    }
    
    
    func getCDCocktails() {
        do {
            favDrinkId = try bartenderAdapter.context.fetch(BartenderDrinks.fetchRequest())
        } catch {
            print("Error Getting items: \(error.localizedDescription)")
        }
    }
    
    func downloadCocktailDetaillsJSON(completed: @escaping () -> ()) {
        for i in 0 ..< favDrinkId.count {
            let item = favDrinkId[i].drinkId as String?
            
            // let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(item!)"
            let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(item ?? "")"
            let url = URL(string: queryURL)!
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)
            let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let unwrappedData = data else {
                    print("No data")
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let list = try jsonDecoder.decode(CocktailResponse.self, from: unwrappedData).drinks
                    //self.cocktailCollection = try jsonDecoder.decode(Cocktails.self, from: unwrappedData).drinks
                    self.drinkDetail.append(contentsOf: list)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}



