//
//  ViewController.swift
//  TwitterAPIApp
//
//  Created by 境将輝 on 2020/03/21.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import SDWebImage


class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var screenName = ""
    var tweetCount = Int()
    
    let headers:HTTPHeaders = ["Authorization": ""]
    
    //var profileImageUrl:String!
    var array = [String]()
    var urlString = String()
    
    
    var tweetArray = [String]()
    
    let refresh = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("screenName",screenName)
        print("tweetCount",tweetCount)
     
        
//        tableView.refreshControl = refresh
//        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
        tableView.reloadData()
        getTweets()
        tableView.delegate = self
        tableView.dataSource = self
       
    }

    func getTweets(){
        let urlText = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenName)&count=\(tweetCount)"
        
        //Getメソッドでツイート取得
        AF.request(urlText, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                
                for i in 0..<self.tweetCount{
                    let json:JSON = JSON(response.data as Any)
                    
                    //ツイート
                    let text = json[i]["text"].string!
                    print(text)
                    self.tweetArray.append(text)
                    
                    //プロフィール画像のURL
                    let profileImageUrl = json[i]["user"]["profile_image_url_https"].string
                    self.array.append(profileImageUrl!)
                    self.urlString = profileImageUrl!
                }
                break
                
            case .failure(let error):
                print(error)
                break
            }
            
            self.tableView.reloadData()
        }
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", tweetArray.count)
        return tweetArray.count
    }

    //セルの構成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //print(profileImageUrl)
//        let profileImageURL = URL(string: array[indexPath.row] as String)!

        let profileImageURL = URL(string: urlString as String)!
        
        
        cell.imageView?.sd_setImage(with: profileImageURL, completed: { (image, error, _, _) in

            if error == nil{
                print("Not error")
                cell.setNeedsLayout()
            }
            else{
                print("--error--")
                print(error)
            }
        })
        
        cell.textLabel?.text = self.tweetArray[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }

    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt", indexPath.row)
        print("NSindexPath.row: ", (indexPath as NSIndexPath).row)
    }
    

    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/7
    }

}

