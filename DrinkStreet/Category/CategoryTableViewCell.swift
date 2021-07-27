//
//  CategoryTableViewCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/27.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryView: UIView!{
        didSet{
            categoryView.layer.cornerRadius = 10
            categoryView.layer.shadowOpacity = 50
            categoryView.layer.shadowRadius = 50
            categoryView.layer.shadowColor = UIColor(named: "Black")?.cgColor
            categoryView.layer.shadowOffset = CGSize(width: 100, height: 200)
            categoryView.backgroundColor = UIColor.systemPink
            categoryView.layer.masksToBounds = false
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
