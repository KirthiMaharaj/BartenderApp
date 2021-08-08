//
//  ViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit


class BartenderDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkAlcoholic: UILabel!
    @IBOutlet weak var drinkInstruction: UILabel!
    @IBOutlet weak var drinkIngredient: UILabel!
    
   // var drinkDetail: DrinkDetail?
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetail()
        // Do any additional setup after loading the view.
    }
    
    fileprivate  func getDetail() {
        drinkName.text = "\(bartenderAdapter.details?.strDrink ?? "")"
        let url = URL(string: "\(bartenderAdapter.details?.strDrinkThumb ?? "")")!
        if let dataImage = try? Data(contentsOf: url){
            drinkImageView.image = UIImage(data: dataImage)
        }
        drinkCategory.text = "Category: \(bartenderAdapter.details?.strCategory ?? "")"
        drinkAlcoholic.text = "Alcoholic: \(bartenderAdapter.details?.strAlcoholic ?? "")"
        drinkInstruction.text = "Instructions: \(bartenderAdapter.details?.strInstructions ?? "")"
        drinkIngredient.text = "Ingredients:" + "\n \(bartenderAdapter.details?.strIngredient1 ?? "")" + "\n \(bartenderAdapter.details?.strIngredient2 ?? "")" + "\n \(bartenderAdapter.details?.strIngredient3 ?? "")"
            + "\n \(bartenderAdapter.details?.strIngredient4 ?? "")" + "\n \(bartenderAdapter.details?.strIngredient5 ?? "")"
            + "\n \(bartenderAdapter.details?.strIngredient6 ?? "")" + "\n \(bartenderAdapter.details?.strIngredient7 ?? "")"
        
    }
    
    
    
}

