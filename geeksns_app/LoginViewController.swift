//
//  LoginViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginbutton(_ sender: Any) {
//    https://teachapi.herokuapp.com/sign_in
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/sign_in"
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params:[String:Any] = [
          "sign_in_user_params": [
            "email": "\(address.text!)",
            "password": "\(password.text!)",
             "password_confirmation": "\(password.text!)"
            ]
        ]
        do{
        req.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }catch{
            print(error.localizedDescription)
        }
        print(req)
        let task = session.dataTask(with: req) { (data, response, error) in
            
           do {
                 let json: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                 UserDefaults.standard.set(json["token"], forKey: "token")
                 UserDefaults.standard.synchronize()
                         
                     } catch {
                         
                     }
                   
               }
               task.resume()
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
            self.navigationItem.hidesBackButton = true
    }

}
