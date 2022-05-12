//
//  ScoreViewController.swift
//  ColorQuizApp
//
//  Created by 山崎颯汰 on 2022/02/20.
//

import UIKit
import GoogleMobileAds

class ScoreViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var returnTopButton: UIButton!
    
    var bannarView: GADBannerView!
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannarView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannarView.adUnitID = "ca-app-pub-5041739959288046/8243856910"
        bannarView.rootViewController = self
        bannarView.load(GADRequest())
        addBannerViewToView(bannarView)
        
        
        scoreLabel.text = "7問中 \(correct)問正解!"
        

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityItems = ["7問中\(correct)問正解しました","#色名クイズアプリ"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
