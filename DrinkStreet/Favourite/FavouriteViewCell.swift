//
//  FavouriteViewCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/25.
//

import UIKit

class FavouriteViewCell: UITableViewCell {

    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favView: UIView! {
        didSet{
            favView.layer.cornerRadius = 10
            favView.layer.shadowOpacity = 10
            favView.layer.shadowRadius = 2
            favView.layer.shadowColor = UIColor(named: "Black")?.cgColor
            favView.layer.shadowOffset = CGSize(width: 10, height: 160)
            favView.backgroundColor = UIColor.systemPink
            favView.layer.masksToBounds = false
        }
    }
    
    let bartenderProvider = BartenderProvider()
    var drinkDetail: DrinkDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
