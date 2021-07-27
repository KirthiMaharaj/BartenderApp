//
//  ViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit
import SwiftOverlays

class BartenderDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
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
        if let superview = self.view.superview {
            SwiftOverlays.showCenteredWaitOverlayWithText(superview, text: "Please wait...")
            SwiftOverlays.removeAllOverlaysFromView(superview)
        }
        getDetail()
        
        // Do any additional setup after loading the view.
    }

  fileprivate  func getDetail() {
        drinkName.text = "\(drinkDetail?.strDrink ?? "")"
        let url = URL(string: "\(drinkDetail?.strDrinkThumb ?? "")")!
        if let dataImage = try? Data(contentsOf: url){
        drinkImageView.image = UIImage(data: dataImage)
        }
        drinkCategory.text = "Category: \(drinkDetail?.strCategory ?? "")"
        drinkAlcoholic.text = "Alcoholic: \(drinkDetail?.strAlcoholic ?? "")"
        drinkInstruction.text = "Instructions: \(drinkDetail?.strInstructions ?? "")"
        drinkIngredient.text = "Ingredients:" + "\n \(drinkDetail?.strIngredient1 ?? "")" + "\n \(drinkDetail?.strIngredient2 ?? "")" + "\n \(drinkDetail?.strIngredient3 ?? "")"
            + "\n \(drinkDetail?.strIngredient4 ?? "")" + "\n \(drinkDetail?.strIngredient5 ?? "")"
            + "\n \(drinkDetail?.strIngredient6 ?? "")" + "\n \(drinkDetail?.strIngredient7 ?? "")"
    }
    
    

}

