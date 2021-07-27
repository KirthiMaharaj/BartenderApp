//
//  InstructionsViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/26.
//

import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var ingreLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    
    let bartenderProvider = BartenderProvider()
    var drinkDetail: DrinkDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // drinkCategory.text = "Category: \(drinkDetail?.strCategory ?? "")"
    fileprivate func getLabel(){
        ingreLabel.text = "Ingredients:" + "\n \(drinkDetail?.strIngredient1 ?? "")" + "\n \(drinkDetail?.strIngredient2 ?? "")" + "\n \(drinkDetail?.strIngredient3 ?? "")"
            + "\n \(drinkDetail?.strIngredient4 ?? "")" + "\n \(drinkDetail?.strIngredient5 ?? "")"
            + "\n \(drinkDetail?.strIngredient6 ?? "")" + "\n \(drinkDetail?.strIngredient7 ?? "")"
        methodLabel.text = "Method: \(drinkDetail?.strInstructions ?? "")"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
