//
//  SelectLevelViewController.swift
//  ColorQuizApp
//
//  Created by 山崎颯汰 on 2022/02/20.
//

import UIKit
import GoogleMobileAds

class SelectLevelViewController: UIViewController {
    @IBOutlet var level1Button: UIButton!
    @IBOutlet var level2Button: UIButton!
    @IBOutlet var level3Button: UIButton!
    
    var bannarView: GADBannerView!
    var selectTag = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        bannarView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannarView.adUnitID = "ca-app-pub-5041739959288046/8243856910"
        bannarView.rootViewController = self
        bannarView.load(GADRequest())
        addBannerViewToView(bannarView)
        
        level1Button.layer.cornerRadius = 20.0
        level2Button.layer.cornerRadius = 20.0
        level3Button.layer.cornerRadius = 20.0


        /*let imageView = UIImageView(image: UIImage(named: "title"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView*/
        
        if let navigationBar = self.navigationController?.navigationBar {
            let imageFrame = CGRect(x: (self.view.frame.size.width / 2) - 70, y: 7, width: 134, height: 30)
            let image = UIImageView(frame: imageFrame)
            image.image = UIImage(named: "title2")
            navigationBar.addSubview(image)
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:  "戻る",
            style:  .plain,
            target: nil,
            action: nil
        )
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLebel = selectTag
    }
    
    @IBAction func levelButtonAction(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0) ,
            NSLayoutConstraint(item: bannerView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
            ])
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
