//
//  BartenderListCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit

//protocol BartenderButtonDelegate: AnyObject {
//    func favButton(didTapButton button: UIButton)
//}
protocol Favourited {
    func toggleFav(didTapButton button: UIButton)
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
    
    @IBOutlet weak var favoriteButton: UIButton!
    var delegate: Favourited?
    var isFav = UserDefaults.standard.bool(forKey: "isFav")
    let bartenderAdapter = BartenderAdapter()
    
    func configure(withInfo drink: DrinkDetail) {
        self.drinkName.text = drink.strDrink
        self.drinkCategory.text = drink.strCategory
        let url = URL(string: "\((drink.strDrinkThumb)!)")
        if let dataImage = try? Data(contentsOf: url!){
            self.drinkImage.image = UIImage(data: dataImage)
        }
        self.favoriteButton.setImage(drink.isFav ? .init(named: "ic_fav") : .init(named:"ic_un_fav"), for: .normal)
    }
    
    @IBAction func favTapped(_ sender: Any) {
       // if let favDrink = bartenderAdapter.details {
            delegate?.toggleFav(didTapButton: sender as! UIButton)
//            if isFav {
//                UserDefaults.standard.set(false, forKey: "isFav")
//                UserDefaults.standard.synchronize()
//                let image = UIImage(named: "ic_un_fav")
//                (sender as AnyObject).setImage(image, for: UIControl.State.normal)
//            }else {
//                UserDefaults.standard.set(true, forKey: "isFav")
//                UserDefaults.standard.synchronize()
//                let image = UIImage(named: "ic_fav")
//                (sender as AnyObject).setImage(image, for: UIControl.State.normal)
//            }
//            isFav = !isFav
//            UserDefaults.standard.set(isFav, forKey: "isFav")
//            UserDefaults.standard.synchronize()
            
       // }

        
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
