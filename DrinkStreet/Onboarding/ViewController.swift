//
//  ViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/24.
//

import UIKit

class BartenderOnboardingViewController2: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    private var items: [OnboardingItem] = []
    private var imageViews = [UIImageView]()
    let bartenderAdapter = BartenderAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        bartenderAdapter.getAllBartender()
        setupPlaceHolderItems()
        setupCollectionView()
        setupPageConrol()
        setupImageViews()

        // Do any additional setup after loading the view.
    }


    @IBAction func nextTapped(_ sender: Any) {
        bartenderAdapter.delegate = self
        bartenderAdapter.getAllBartender()
        let nextRow = getCurrentIndex() + 1
        print("current index: \(getCurrentIndex())")

        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)

        showItem(at: nextRow)
       
    }
    @IBAction func pageAction(_ sender: Any) {
        collectionView!.scrollRectToVisible(CGRect(x: collectionViewWidth * CGFloat ((page?.currentPage)!), y: 0, width: collectionViewWidth, height: 650), animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }

    private func setupPageConrol() {
       
        page.numberOfPages = items.count
        page.currentPage = 0
    }

    private func showItem(at index: Int) {
        page.currentPage = index
        let shouldShow = index == items.count - 1
        nextButton.isHidden = shouldShow
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }

    private func setupImageViews() {
        items.forEach { item in
            let imageView = UIImageView(image:  item.image)
            imageView.contentMode = .scaleToFill
            imageView.alpha = 0.0
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])

            imageViews.append(imageView)
        }

        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(collectionView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        let canShow = (index < items.count - 1)
        guard canShow else {
            return
        }
        page.currentPage = Int(x)
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
    

    var collectionViewWidth: CGFloat {
        return collectionView.frame.size.width
    }

    private func setupPlaceHolderItems() {
        items = OnboardingItem.placeHolderItems
    }



}
extension BartenderOnboardingViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! QuotesCollectionViewCell
        let item = items[indexPath.item]
        let shouldShow = indexPath.item == items.count - 1

        cell.delegate = self
        cell.configure(with: item)
        cell.showExploreButton(shouldShow: shouldShow)
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension  BartenderOnboardingViewController2: QuoteCollectionViewCellDelegate {

    func didTapExploreButton() {
        print("tapped")
        let controller = storyboard?.instantiateViewController(identifier: "Onboarding") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .partialCurl
        UserDefaults.standard.hasOnboarded = true
        present(controller, animated: true, completion: nil)
        nextButton.isEnabled = false
    }

}

extension BartenderOnboardingViewController2: BartenderAdaptersProtocol {
    static var userQuery: String?
    func getAllBartender() {
        DispatchQueue.main.async {
            self.navigationItem.title = "21 Drink Street"
        }
    }
}
