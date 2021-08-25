//
//  BartenderListCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

class BartenderListCell: UITableViewCell {
    
    var favController: FavouriteViewController?
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var barContainerView: UIView!{
        didSet{
            barContainerView.layer.cornerRadius = 40
            barContainerView.layer.shadowOpacity = 10
            barContainerView.layer.shadowRadius = 2
            barContainerView.layer.shadowColor = UIColor(named: "Black")?.cgColor
            barContainerView.layer.shadowOffset = CGSize(width: 10, height: 160)
            barContainerView.backgroundColor = UIColor.systemPink
            barContainerView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    func configure(withInfo drink: DrinkDetail) {
        self.drinkName.text = drink.strDrink
        self.drinkCategory.text = drink.strCategory
        
        let url = URL(string: "\((drink.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            self.drinkImage.image = UIImage(data: dataImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
