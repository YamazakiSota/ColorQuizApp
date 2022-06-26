//
//  QuizViewController.swift
//  ColorQuizApp
//
//  Created by 山崎颯汰 on 2022/02/20.
//

import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {

    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizColorImage: UIImageView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var judgeImageView: UIImageView!
    @IBOutlet var quizLabel: UILabel!
    
    var bannarView: GADBannerView!
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLebel = 0
    var nums = [2, 3, 4, 5]
    var ans = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannarView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannarView.adUnitID = "ca-app-pub-5041739959288046/8243856910"
        bannarView.rootViewController = self
        bannarView.load(GADRequest())
        addBannerViewToView(bannarView)
        
        
        answerButton1.layer.cornerRadius = 20.0
        answerButton2.layer.cornerRadius = 20.0
        answerButton3.layer.cornerRadius = 20.0
        answerButton4.layer.cornerRadius = 20.0
        
       
        
        
        print("選択したのはレベル\(selectLebel)")
        answerButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton4.titleLabel?.adjustsFontSizeToFitWidth = true
        
        csvArray = loadCSV(fileName: "Quiz\(selectLebel)")
        csvArray.shuffle()
        print(csvArray)
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizColorImage.image = UIImage(named: "\(quizArray[0])")
        nums.shuffle()
        answerButton1.setTitle(quizArray[nums[0]], for: .normal)
        answerButton2.setTitle(quizArray[nums[1]], for: .normal)
        answerButton3.setTitle(quizArray[nums[2]], for: .normal)
        answerButton4.setTitle(quizArray[nums[3]], for: .normal)
        quizLabel.text = quizArray[6]
        
        answerButton1.layer.borderWidth = 1
        answerButton1.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton2.layer.borderWidth = 1
        answerButton2.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton3.layer.borderWidth = 1
        answerButton3.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton4.layer.borderWidth = 1
        answerButton4.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        
        answerButton1.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton2.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton3.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        answerButton4.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
        
        
        if quizArray[1] == String(nums[0] - 1) {
            ans = 1
        }
        else if quizArray[1] == String(nums[1] - 1) {
            ans = 2
        }
        else if quizArray[1] == String(nums[2] - 1) {
            ans = 3
        }
        else if quizArray[1] == String(nums[3] - 1) {
            ans = 4
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    //ボタンを押したときに呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == ans {
            correctCount += 1
            print("正解")
            self.judgeImageView.isHidden = false
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            self.judgeImageView.isHidden = false
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア：\(correctCount)")
        
        if  sender.tag == 1 {
            if ans == 1 {
                answerButton1.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton2.isHidden = true
                answerButton3.isHidden = true
                answerButton4.isHidden = true
            }else if ans == 2 {
                answerButton2.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton2.isEnabled = false
                answerButton3.isHidden = true
                answerButton4.isHidden = true
            }else if ans == 3 {
                answerButton3.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton2.isHidden = true
                answerButton3.isEnabled = false
                answerButton4.isHidden = true
            }else if ans == 4 {
                answerButton4.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton2.isHidden = true
                answerButton3.isHidden = true
                answerButton4.isEnabled = false
            }
        } else if sender.tag == 2 {
            if ans == 1 {
                answerButton1.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton2.isEnabled = false
                answerButton3.isHidden = true
                answerButton4.isHidden = true
            }else if ans == 2 {
                answerButton2.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isEnabled = false
                answerButton3.isHidden = true
                answerButton4.isHidden = true
            }else if ans == 3 {
                answerButton3.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isEnabled = false
                answerButton3.isEnabled = false
                answerButton4.isHidden = true
            }else if ans == 4 {
                answerButton4.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isEnabled = false
                answerButton3.isHidden = true
                answerButton4.isEnabled = false
            }
        } else if sender.tag == 3 {
            if ans == 1 {
                answerButton1.layer.borderColor = UIColor.red.cgColor
                answerButton1.isEnabled = false
                answerButton3.isEnabled = false
                answerButton2.isHidden = true
                answerButton4.isHidden = true
            }else if ans == 2 {
                answerButton2.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isEnabled = false
                answerButton3.isEnabled = false
                answerButton4.isHidden = true
            }else if ans == 3 {
                answerButton3.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isHidden = true
                answerButton3.isEnabled = false
                answerButton4.isHidden = true
            }else if ans == 4 {
                answerButton4.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isHidden = true
                answerButton3.isEnabled = false
                answerButton4.isEnabled = false
            }
        } else if sender.tag == 4 {
            if ans == 1 {
                answerButton1.layer.borderColor = UIColor.red.cgColor
                answerButton4.isEnabled = false
                answerButton1.isEnabled = false
                answerButton2.isHidden = true
                answerButton3.isHidden = true
            }else if ans == 2 {
                answerButton2.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isEnabled = false
                answerButton4.isEnabled = false
                answerButton3.isHidden = true
            }else if ans == 3 {
                answerButton3.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isHidden = true
                answerButton3.isEnabled = false
                answerButton4.isEnabled = false
            }else if ans == 4 {
                answerButton4.layer.borderColor = UIColor.red.cgColor
                answerButton1.isHidden = true
                answerButton2.isHidden = true
                answerButton3.isHidden = true
                answerButton4.isEnabled = false
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.answerButton1.isHidden = false
            self.answerButton2.isHidden = false
            self.answerButton3.isHidden = false
            self.answerButton4.isHidden = false
            self.answerButton1.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton2.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton3.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton4.layer.borderColor = CGColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton1.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton2.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton3.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.answerButton4.backgroundColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha:1.0)
            self.nextQuiz()
        }
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < 7 {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizColorImage.image = UIImage(named: "\(quizArray[0])")
            nums.shuffle()
            answerButton1.setTitle(quizArray[nums[0]], for: .normal)
            answerButton2.setTitle(quizArray[nums[1]], for: .normal)
            answerButton3.setTitle(quizArray[nums[2]], for: .normal)
            answerButton4.setTitle(quizArray[nums[3]], for: .normal)
            quizLabel.text = quizArray[6]
            
            if quizArray[1] == String(nums[0] - 1) {
                ans = 1
            }
            else if quizArray[1] == String(nums[1] - 1) {
                ans = 2
            }
            else if quizArray[1] == String(nums[2] - 1) {
                ans = 3
            }
            else if quizArray[1] == String(nums[3] - 1) {
                ans = 4
            }
            
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
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
