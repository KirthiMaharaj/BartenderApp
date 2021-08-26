//
//  BartenderTableViewController.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/07/22.
//

import UIKit
import ProgressHUD
import CoreData

class BartenderTableViewController: UITableViewController {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    let bartenderAdapter = BartenderAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicate()
        self.bindDrinkModel()
        self.bartenderAdapter.getAllBartender()
    }
    
    fileprivate func bindDrinkModel() {
        self.bartenderAdapter.delegate = self
    }
    
    fileprivate func activityIndicate() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.showProgress(0.60)
        ProgressHUD.show()
    }
    
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        guard bartenderAdapter.shareEnabled else {
            bartenderAdapter.shareEnabled = true
            tableView?.allowsMultipleSelection = true
            shareButton.title = "Done"
            shareButton.style = UIBarButtonItem.Style.plain
            return
        }
        
        guard bartenderAdapter.selectedImages.count > 0 else {return}
        
        let snapshots = bartenderAdapter.selectedImages.map { $0.snapshot }
        
        let activityController = UIActivityViewController(activityItems: snapshots as [Any], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (activityType, completed, returnedItem, error) in
            //Deselect all selected items
            if let indexPaths = self.tableView?.indexPathsForSelectedRows {
                for indexPath in indexPaths {
                    self.tableView.deselectRow(at: indexPath, animated: false)
                }
            }
            activityController.popoverPresentationController?.sourceView = self.view
            activityController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.mail]
            //Remove all items from selectedImages array
            self.bartenderAdapter.selectedImages.removeAll(keepingCapacity: true)
            
            //Change the sharing mode to No
            self.bartenderAdapter.shareEnabled = false
            self.tableView?.allowsMultipleSelection = false
            self.shareButton.image = UIImage(systemName: "square.and.arrow.up")
            self.shareButton.style = UIBarButtonItem.Style.plain
            
        }
        present(activityController, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bartenderAdapter.drinkDetail.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BartenderListCell", for: indexPath) as! BartenderListCell
        // Configure the cell..."reuseIdentifier"
        
        cell.favoriteButton.tag = indexPath.row
        let fav = checkIfExists(bartenderAdapter.drinkDetail[indexPath.row].drinksId ?? "")
        if fav == false{
            cell.favoriteButton.setImage(UIImage(named: "ic_un_fav"), for: .normal)
            cell.configure(withInfo: self.bartenderAdapter.drinkDetail[indexPath.row])
        }else {
            cell.favoriteButton.setImage(UIImage(named: "ic_fav"), for: .normal)
            cell.configure(withInfo: self.bartenderAdapter.drinkDetail[indexPath.row])
        }
       
        cell.selectionStyle = .blue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if bartenderAdapter.shareEnabled == false {
           // performSegue(withIdentifier: "SegueShowDetail", sender: nil)
        }else {
            let selected = bartenderAdapter.drinkDetail[indexPath.row]
            if let snapshot = tableView.cellForRow(at: indexPath)?.snapshot {
                bartenderAdapter.selectedImages.append((image: selected, snapshot: snapshot))
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard bartenderAdapter.shareEnabled else {return}
        let deselected = bartenderAdapter.drinkDetail[indexPath.row]
        if let index = bartenderAdapter.selectedImages.firstIndex(where: { $0.image.strDrinkThumb == deselected.strDrinkThumb }) {
            bartenderAdapter.selectedImages.remove(at: index)
        }
    }
    
    
    func checkIfExists( _ itemID: String) -> Bool {
        var numRecords:Int = 0
        do {
            let request: NSFetchRequest<BartenderDrinks> = BartenderDrinks.fetchRequest()
            request.predicate = NSPredicate(format: "drinkId == %@", itemID)
            
            numRecords = try bartenderAdapter.context.count(for: request)
            print("We're counting our items: \(numRecords)")
        } catch {
            print("Error in checking items: \(error.localizedDescription)")
        }
        if numRecords == 0 {
            return false
        } else {
            return true
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BartenderDetailViewController {
            destination.bartenderAdapter.details =  bartenderAdapter.drinkDetail[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }
}

extension BartenderTableViewController: BartenderAdaptersProtocol {
    static var userQuery: String?
    func getAllBartender() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = "21 Drink Street"
        }
    }
}
