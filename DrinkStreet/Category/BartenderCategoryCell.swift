//
//  BartenderCategoryCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/30.
//

import UIKit

class BartenderCategoryCell: UITableViewCell {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    @IBOutlet weak var barView: UIView!{
        didSet{
            barView.layer.cornerRadius = 10
            barView.layer.shadowOpacity = 50
            barView.layer.shadowRadius = 50
            barView.layer.shadowColor = UIColor(named: "Black")?.cgColor
            barView.layer.shadowOffset = CGSize(width: 100, height: 200)
            barView.backgroundColor = UIColor.systemPink
            barView.layer.masksToBounds = false
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
