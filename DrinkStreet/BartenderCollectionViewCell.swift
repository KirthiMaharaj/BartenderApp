//
//  BartenderCollectionViewCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/23.
//

import UIKit

class BartenderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var barCategory: UILabel!
    @IBOutlet weak var barImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.barImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.barImageView.layer.cornerRadius = CGFloat(roundf(Float(self.barImageView.frame.size.width / 2.0)))
    }
    
}
