//
//  BartenderListCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

protocol BartenderListCellDelegate: AnyObject {
    func didTapMakeFavourite(button: UIButton)
}

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
    weak var delegate: BartenderListCellDelegate?
    @IBOutlet weak var favoriteButton: UIButton!
    //    var addActionHandler: (() -> Void)?
    //    let isFav = UserDefaults.standard.bool(forKey: "isFav")
//    override var accessibilityElements: [Any]? {
//        set {}
//        get{
//            return[
//                self.drinkName as Any,
//                self.drinkCategory as Any,
//                self.drinkImage as Any,
//                self.favoriteButton as Any
//            ]
//        }
//    }

    func fav(withDetail detail: DrinkDetail){
//        self.drinkName.text = detail.strDrink
//        self.drinkCategory.text = detail.strCategory
//        let  url = URL(string: "\((detail.strDrinkThumb)!)")
//        if let dataImage = try? Data(contentsOf: url!){
//            self.drinkImage.image = UIImage(data: dataImage)
//        }
        self.favoriteButton.isSelected = detail.isFav
        self.applyAccessibility()
    }
    
    @IBAction func favTapped(_ sender: UIButton) {
        self.delegate?.didTapMakeFavourite(button: sender)
        //        self.addActionHandler?()
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
    
    
    private func applyAccessibility() {
        self.favoriteButton.accessibilityLabel = "favourite"
        self.favoriteButton.accessibilityHint = self.favoriteButton.isSelected ? "makes favourite" : "removes favourite"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
        // self.favoriteButton.backgroundColor = UIColor.clear
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
