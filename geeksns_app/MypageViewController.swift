//
//  MypageViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var Mypage: [[String: Any]]?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MypageCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! MypageCell
        
    if let Mypage = Mypage {
        MypageCell.post.text = Mypage[indexPath.row]["text"] as? String
        MypageCell.name.text =  (Mypage[indexPath.row]["user"] as? [String: Any])?["name"] as? String
    }
        return MypageCell
    }
override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    //    https://teachapi.herokuapp.com/posts
    let config: URLSessionConfiguration = URLSessionConfiguration.default
    let session: URLSession = URLSession(configuration: config)
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "teachapi.herokuapp.com"
    urlComponents.path = "/posts"
    
    let url: URL = urlComponents.url!
    var req: URLRequest = URLRequest(url: url)
    req.httpMethod = "GET"
    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
    req.addValue("Bearer 0EEH4pOkgPWIQYXTS2Y3LQtt", forHTTPHeaderField: "Authorization")
    let task = session.dataTask(with: req) { (data, response, error) in
        
        do {
            let json: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
            
            self.Mypage = json
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
        
    }
    task.resume()
    }
}


