//
//  BartenderView.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/02.
//

import UIKit

class BartenderOnboardingViewController: UIViewController, UIScrollViewDelegate{
    
   
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    let bartenderAdapter = BartenderAdapter()
    var titles = [" Welcome To 21 Drink Street","Drinks","About"]
    var descs = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
    var imgs = ["3","4","5"]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scroll.frame.size.width
        scrollHeight = scroll.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        onboardingDetail()
        // Do any additional setup after loading the view.
    }
    


    
    @IBAction func pageChanged(_ sender: Any) {
        scroll!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageController?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    

    @IBAction func startedTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "Onboarding") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        UserDefaults.standard.hasOnboarded = true
        present(controller, animated: true, completion: nil)
    }
    
    
    func onboardingDetail() {
        self.scroll.delegate = self
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            // Do any additional setup after loading the view.
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:400,height:500)
            imageView.contentMode = .scaleToFill
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = titles[index]
            
            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
            txt2.textAlignment = .center
            txt2.numberOfLines = 3
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.text = descs[index]
            
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scroll.addSubview(slide)
        }
        
        scroll.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scroll.contentSize.height = 1.0
        
        //initial state
        pageController.numberOfPages = titles.count
        pageController.currentPage = 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }

        func setIndiactorForCurrentPage()  {
            let page = (scroll?.contentOffset.x)!/scrollWidth
            pageController?.currentPage = Int(page)
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


extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
}

