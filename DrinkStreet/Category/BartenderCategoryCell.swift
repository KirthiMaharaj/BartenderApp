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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
