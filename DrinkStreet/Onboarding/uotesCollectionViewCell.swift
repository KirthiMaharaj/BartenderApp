//
//  uotesCollectionViewCell.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/24.
//

import UIKit

protocol  QuoteCollectionViewCellDelegate: AnyObject {
    func didTapExploreButton()
}

class QuotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var exploreButton: UIButton!
    weak var delegate: QuoteCollectionViewCellDelegate?
    
    func configure(with item: OnboardingItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
    
    func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    @IBAction func exporeTapped(_ sender: Any) {
        delegate?.didTapExploreButton()    }
}
