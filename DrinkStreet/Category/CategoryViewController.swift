//
//  CategoryViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/28.
//

import UIKit



class CategoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let reuseIdentifier:String = "CategoryViewCell"
    
    let bartenderProvider = BartenderProvider()
    var drinkDetail = [DrinkDetail](){
        didSet{
            DispatchQueue.main.async { [self] in
                self.collectionView.reloadData()
                self.navigationItem.title = "21 Drink Street"

            }
        }
    }
//    var drinkDetail: DrinkDetail?
//    var cateDetail = [CategoryDetails](){
//        didSet{
//            DispatchQueue.main.async { [self] in
//                self.collectionView.reloadData()
//                self.navigationItem.title = "21 Drink Street"
//
//            }
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        getBartenderCategory()
        // Register cell classes
        collectionView.backgroundColor = .purple
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func getBartenderCategory() {
        bartenderProvider.fetchBratenderAPI { [weak self] result in
            switch result {
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

    
    
//    fileprivate func getBartenderCategory() {
//        bartenderProvider.fetchCategoryAPI { [weak self] result in
//            switch result {
//            case .success(let category):
//                self?.cateDetail = category
//                DispatchQueue.main.async {
//                    self?.collectionView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
    
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
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryViewCell
        // Configure the cell
//        let categoryDrinks = drinkDetail[indexPath.item]
//        cell.categoryLabel?.text = "\(categoryDrinks.strCategory)"
        //cell.categoryLabel.text = drinkDetail[indexPath.item].strCategory
        cell.categoryLabel.text = "LLL"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.frame.width
            let height = CGFloat(200)
            
            return CGSize(width: width, height: height)
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
