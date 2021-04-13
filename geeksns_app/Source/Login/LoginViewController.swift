//
//  LoginViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 47 / 2
        }
    }
    @IBOutlet private weak var addressTextField: UITextField! {
        didSet {
            addressTextField.borderStyle = .none
            addressTextField.layer.cornerRadius = 15
            addressTextField.layer.borderWidth  = 0.5
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.borderStyle = .none
            passwordTextField.layer.cornerRadius = 15
            passwordTextField.layer.borderWidth  = 0.5
        }
    }
    @IBAction func loginbutton(_ sender: Any) {
        loginApi()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func loginApi() {
        // https://teachapi.herokuapp.com/sign_in
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
                "email": "\(addressTextField.text!)",
                "password": "\(passwordTextField.text!)",
                "password_confirmation": "\(passwordTextField.text!)"
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

            } catch {}
        }
        task.resume()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
