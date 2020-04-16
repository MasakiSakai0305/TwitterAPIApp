//
//  InitialViewController.swift
//  TwitterAPIApp
//
//  Created by 境将輝 on 2020/03/27.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var tweetCountTextField: UITextField!
    
    
    var userName:String!
    var tweetCount:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goTweet(_ sender: Any) {
        print("--goTweet--")
        userName = userNameTextField.text!
        tweetCount = Int(tweetCountTextField.text!)
        print(userName!)
        print(tweetCount!)
        
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
           //Segueの識別子確認
           if segue.identifier == "TimeLine" {
    
               //遷移先ViewCntrollerの取得
               let tlVC = segue.destination as! TimeLineViewController
    
               //値の設定
               tlVC.screenName = userName
               tlVC.tweetCount = tweetCount
           }
       }
    

}
