//
//  CategoryCollectionViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/27.
//

import UIKit

private let reuseIdentifier = "CategoryCollectionViewCell"

class CategoryCollectionViewController: UICollectionViewController {
    
    
    let bartenderProvider = BartenderProvider()
    var categoryDetail :CategoryDetails?
    
    var drinkDetail = [DrinkDetail]() {
        didSet{
            DispatchQueue.main.async { [self] in
                //activityIndicator.animating = true
                // activityIndicator.startAnimating()
                self.collectionView.reloadData()
                self.navigationItem.title = "21 Drink Street"
                
            }
        }
    }
    
    var drinkDetails: DrinkDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView!.bounds.width, height: 100)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        getBartender()
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func getBartender() {
        bartenderProvider.fetchBratenderAPI { [weak self] drink in
            switch drink{
            case .success(let drinks):
                self?.drinkDetail = drinks
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return drinkDetail.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        // Configure the cell
        let cateDetail = drinkDetail[indexPath.item]
        
//        if let categorys = categoryDetail  {
//            for category in categorys {
//                if category.strCategory == cateDetail.strCategory {
//                    let url = URL(string: "\(cateDetail.strDrinkThumb)")
//                    if let dataImage = try? Data(contentsOf: url!){
//                        cell.cateImage.image = UIImage(data: dataImage)
//                    }
//                }
//            }
//        }
            let url = URL(string: "\(cateDetail.strDrinkThumb)")
            if let dataImage = try? Data(contentsOf: url!){
                cell.cateImage.image = UIImage(data: dataImage)
            }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
