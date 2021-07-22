//
//  ViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

class BartenderDetailViewController: UIViewController {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkAlcoholic: UILabel!
    @IBOutlet weak var drinkInstruction: UILabel!
    @IBOutlet weak var drinkIngredient: UILabel!
    
    let bartenderProvider = BartenderProvider()
    var drinkDetail: DrinkDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
        // Do any additional setup after loading the view.
    }

    func getDetail() {
        drinkName.text = "\(drinkDetail?.strDrink ?? "")"
        let url = URL(string: "\(String(describing: drinkDetail?.strDrinkThumb))")
        if let dataImage = try? Data(contentsOf: url!){
        drinkImageView.image = UIImage(data: dataImage)
        }
        drinkCategory.text = "Category: \(drinkDetail?.strCategory ?? "")"
        drinkAlcoholic.text = "Alcoholic: \(drinkDetail?.strAlcoholic ?? "")"
        drinkInstruction.text = "Instructions: \(drinkDetail?.strInstructions ?? "")"
       // drinkIngredient.text = "Ingredients:" + "\(drinkDetail?.strIngredient1 ?? "")" + "\(drinkDetail?.strIngredient2 ?? "")" + "\(drinkDetail?.strIngredient3 ?? "")" + "\(drinkDetail?.strIngredient4 ?? "")" + "\(drinkDetail?.strIngredient5 ?? "")"
    }

}

