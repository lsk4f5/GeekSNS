//
//  RegisterViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
//    登録ボタン
    @IBOutlet weak var touroku: UIButton!
    @IBOutlet weak var newname: UITextField!
    @IBOutlet weak var newmail: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var newpass2: UITextField!
    
    @IBAction func back_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    登録ボタン
    @IBAction func register(_ sender: Any) {
        
        //        https://teachapi.herokuapp.com/sign_up
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/sign_up"
        
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params:[String:Any] = [
          "sign_up_user_params": [
            "name": "\(newname.text!)",
              "bio": "a",
              "email": "\(newmail.text!)",
              "password": "\(newpass.text!)",
              "password_confirmation": "\(newpass2.text!)"
            ]
        ]
        
        do{
            req.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }catch{
            print(error.localizedDescription)
        }
        
        print(req)
        let task = session.dataTask(with: req) { (data, response, error) in
            //            tokenせーぶしてるコード。これを登録とかログインに書くとどこでもtoken使えるようになる
            do {
                let json: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                UserDefaults.standard.set(json["token"], forKey: "token")
                UserDefaults.standard.synchronize()
                
            } catch {
                
            }
            
        }
        task.resume()
                
    }

    //        パスワード違っても弾かれない系
    func textFieldDidEndEditing(_ textField: UITextField) {
        if newpass.text == newpass2.text {
            touroku.isEnabled = true

        } else {

            touroku.isEnabled = false
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    override func viewDidLoad() {
    super.viewDidLoad()
//        touroku.isEnabled = false
        newpass.delegate = self
        newpass2.delegate = self
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        touroku.layer.cornerRadius = 23;
        newpass.isSecureTextEntry = true
        newpass2.isSecureTextEntry = true
    }
    
}
