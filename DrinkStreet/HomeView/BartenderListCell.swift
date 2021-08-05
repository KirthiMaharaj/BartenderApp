//
//  BartenderListCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

class BartenderListCell: UITableViewCell {
    
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
    var addActionHandler: (() -> Void)?
    // let isFav = UserDefaults.standard.bool(forKey: "isFav")
    
    @IBAction func favTapped(_ sender: UIButton) {
        self.addActionHandler?()
        //        if isFav == true {
        //            UserDefaults.standard.set(false, forKey: "isFav")
        //            UserDefaults.standard.synchronize()
        //            let image = UIImage(systemName: "heart")
        //            sender.setImage(image, for: UIControl.State.normal)
        //        }else {
        //            UserDefaults.standard.set(true, forKey: "isFav")
        //            UserDefaults.standard.synchronize()
        //            let image = UIImage(systemName: "heart.fill")
        //            sender.setImage(image, for: UIControl.State.normal)
        //
        //        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.favoriteButton.backgroundColor = UIColor.clear
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
