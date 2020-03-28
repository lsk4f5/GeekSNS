//
//  ChangeViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/11.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
        
    @IBOutlet weak var name_change: UITextField!
    @IBOutlet weak var bio_change: UITextField!
    @IBAction func cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func change_button(_ sender: Any) {
        //    https://teachapi.herokuapp.com/users/{id}
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        
        urlComponents.host = "teachapi.herokuapp.com"
        
        urlComponents.path = "/users/1160"
           
        
        let url: URL = urlComponents.url!
        
        var req: URLRequest = URLRequest(url: url)
        
        req.httpMethod = "PUT"
        
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //        トークン使ってる
        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        
        req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        var userParameter = [String: Any]()
        var param = [String: Any]()
        param["name"] = name_change.text
        param["bio"] = bio_change.text
        userParameter["user_params"] = param
        req.httpBody = try! JSONSerialization.data(withJSONObject: userParameter, options: .fragmentsAllowed)
        
        let task = session.dataTask(with: req) { (data, response, error) in
            do {
                let json: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print(json)
                
            }catch {
                
            }
        }
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
//        self.navigationController?.popViewController(animated: true)
    }
}
