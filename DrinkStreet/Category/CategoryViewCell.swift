//
//  CategoryViewCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/28.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
