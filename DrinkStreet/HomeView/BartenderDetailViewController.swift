//
//  ViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit
import CoreData
import Foundation

class BartenderDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkAlcoholic: UILabel!
    @IBOutlet weak var drinkInstruction: UILabel!
    @IBOutlet weak var drinkIngredient: UILabel!
    @IBOutlet weak var drinkFavButton: UIButton!
    
    var cocktailID:String?
    var drinkDetail = [DrinkDetail]()
    var details: DrinkDetail?
    
    let bartenderAdapter = BartenderAdapter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadCocktailDetaillsJSON {
            self.details = self.drinkDetail[0]
            self.getDetail()
        }
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        let checkRecord = checkIfExists((bartenderAdapter.details!.drinksId)!)
        
        if checkRecord == false
        {
            addFavouriteCocktail((bartenderAdapter.details?.drinksId)!)
            self.drinkFavButton.setImage(UIImage(named: "ic_fav"), for: .normal)
            let alert  = UIAlertController(title: "Succesfully Addded", message: "\((bartenderAdapter.details?.drinksId)!) added to your favourites!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            let alert  = UIAlertController(title: "Existing Item", message: "Already in favourites!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.deleteFavourite((self!.bartenderAdapter.details?.drinksId)!)
                self!.drinkFavButton.setImage(UIImage(named: "ic_un_fav"), for: .normal)
                let notifier  = UIAlertController(title: "Succesfully Removed", message: "\((self!.bartenderAdapter.details?.drinksId)!) removed from your favourites!", preferredStyle: .alert)
                notifier.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self!.present(notifier, animated: true)
                
            }))
            self.present(alert, animated: true)
        }
    }
    
    fileprivate  func getDetail() {
        drinkName.text = "\(details?.strDrink ?? "")"
        
        self.drinkImageView.downloaded(from: self.details?.strDrinkThumb ?? "")
        drinkCategory.text = "Category: \(details?.strCategory ?? "")"
        drinkAlcoholic.text = "Alcoholic: \(details?.strAlcoholic ?? "")"
        drinkInstruction.text = "Instructions: \(details?.strInstructions ?? "")"
        drinkIngredient.text = "Ingredients:" + "\n \(details?.strIngredient1 ?? "")" + "\n \(details?.strIngredient2 ?? "")" + "\n \(details?.strIngredient3 ?? "")"
            + "\n \(details?.strIngredient4 ?? "")" + "\n \(details?.strIngredient5 ?? "")"
            + "\n \(details?.strIngredient6 ?? "")" + "\n \(details?.strIngredient7 ?? "")"
        
    }
    
    
    func favBtnStatus( _ itemID: String) {
        let checkRecord = checkIfExists((bartenderAdapter.details?.drinksId)!)
        
        if checkRecord == false {
            self.drinkFavButton.setImage(UIImage(named: "ic_un_fav"), for: .normal)
        } else {
            self.drinkFavButton.setImage(UIImage(named: "ic_fav"), for: .normal)
        }
    }
    
    
    func addFavouriteCocktail( _ itemID: String) {
        let newItem = BartenderDrinks(context: bartenderAdapter.context)
        newItem.drinkId = itemID
        do {
            try bartenderAdapter.context.save()
            print("Favourite Cocktail Saved")
        } catch {
            print("Save Error: \(error.localizedDescription)")
        }
        
    }
    
    func checkIfExists( _ itemID: String) -> Bool {
        var numRecords:Int = 0
        do {
            let request: NSFetchRequest<BartenderDrinks> = BartenderDrinks.fetchRequest()
            request.predicate = NSPredicate(format: "drinkId == %@", itemID)
            
            numRecords = try bartenderAdapter.context.count(for: request)
            print("We're counting our items: \(numRecords)")
        } catch {
            print("Error in checking items: \(error.localizedDescription)")
        }
        if numRecords == 0 {
            return false
        } else {
            return true
        }
    }
    
    func deleteFavourite( _ itemID: String) {
        do{
            let request: NSFetchRequest<BartenderDrinks> = BartenderDrinks.fetchRequest()
            request.predicate = NSPredicate(format: "drinkId == %@", itemID)
            
            bartenderAdapter.favDrinkId = try bartenderAdapter.context.fetch(request)
        } catch {
            
        }
        bartenderAdapter.context.delete(bartenderAdapter.favDrinkId[0])
        
        do {
            try bartenderAdapter.context.save()
        } catch {
            print("Save Error: \(error.localizedDescription)")
        }
    }
    
    func downloadCocktailDetaillsJSON(completed: @escaping () -> ()) {
        let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(cocktailID!)"
        
        let url = URL(string: queryURL)!
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        let task = urlSession.dataTask(with: urlRequest) {
            data, urlResponse, error in
            
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
                self.drinkDetail = try jsonDecoder.decode(CocktailResponse.self, from: unwrappedData).drinks
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


