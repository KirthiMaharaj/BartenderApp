//
//  BartenderView.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/02.
//

import UIKit
import ProgressHUD
class BartenderOnboardingViewController: UIViewController, UIScrollViewDelegate{
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    let bartenderAdapter = BartenderAdapter()
    
    var titles = [" Welcome To 21 Drink Street","Drinks","About"]
    var descs = ["Welcome to our bartender App 21 Drink Street"," We have an varity of drinks. Our drinks are non-alcoholic and alcoholic","This app is about finding your perfect drink. That have different category with ingredient and instructions so that you can make it."]
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
        bartenderAdapter.delegate = self
        bartenderAdapter.getAllBartender()
        let controller = storyboard?.instantiateViewController(identifier: "Onboarding") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .partialCurl
        UserDefaults.standard.hasOnboarded = true
        present(controller, animated: true, completion: nil)
        startButton.isEnabled = false
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
    
    
}


extension BartenderOnboardingViewController: BartenderAdaptersProtocol {
    static var userQuery: String?
    func getAllBartender() {
        DispatchQueue.main.async {
            self.navigationItem.title = "21 Drink Street"
        }
    }
}
