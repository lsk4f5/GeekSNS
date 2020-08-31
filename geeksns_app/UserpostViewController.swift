//
//  UserpostViewController.swift
//  geeksns_app
//
//  Created by osakamiseri on 2020/03/26.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class UserpostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var follow_button: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func follow(_ sender: Any) {
//        POST https://teachapi.herokuapp.com/users/:id/follow
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/users/:id/follow"
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: req) { (data, response, error) in
        do {
         let json: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]

            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
            }
           catch {
           }
        }
}
    
    @IBOutlet weak var tableView: UITableView!
    
    var Userpost: [[String: Any]]?
    func tableView(
      _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let UserpostCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! UserpostCell
           
       if let Userpost = Userpost {
           UserpostCell.userpost.text = Userpost[indexPath.row]["text"] as? String
           UserpostCell.username.text =  (Userpost[indexPath.row]["user"] as? [String: Any])?["name"] as? String
       }
           return UserpostCell
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        follow_button.layer.cornerRadius = 15;
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

            self.Userpost = json
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            }
            }
             task.resume()
    }
}
