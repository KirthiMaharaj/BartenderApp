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
    @IBOutlet weak var favCategory: UILabel!
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
    var isFav = UserDefaults.standard.bool(forKey: "isFav")
    let bartenderAdapter = BartenderAdapter()
    
    
    func configure(withInfo drink: DrinkDetail) {
        self.favName.text = drink.strDrink
        self.favCategory.text = drink.strCategory
        let url = URL(string: "\((drink.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            self.favImageView.image = UIImage(data: dataImage)
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
