//
//  BartenderFirstTabBar.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/01.
//

import UIKit

class BartenderFirstTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "onboradingComplete") {
            present()
        }
    }
    
    func present(){
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        if let myView = storyborad.instantiateViewController(identifier: "Onborading") as? BartenderView {
            myView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(myView, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
