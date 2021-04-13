//
//  RegisterViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = 23
        }
    }
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            nameTextField.borderStyle = .none
            nameTextField.layer.cornerRadius = 15
            nameTextField.layer.borderWidth  = 0.5
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.borderStyle = .none
            emailTextField.layer.cornerRadius = 15
            emailTextField.layer.borderWidth  = 0.5
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.isSecureTextEntry = true
            passwordTextField.borderStyle = .none
            passwordTextField.layer.cornerRadius = 15
            passwordTextField.layer.borderWidth  = 0.5
        }
    }
    @IBOutlet private weak var passwordReenterTextField: UITextField! {
        didSet {
            passwordReenterTextField.delegate = self
            passwordReenterTextField.isSecureTextEntry = true
            passwordReenterTextField.borderStyle = .none
            passwordReenterTextField.layer.cornerRadius = 15
            passwordReenterTextField.layer.borderWidth  = 0.5
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func register(_ sender: Any) {
        registerApi()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if passwordTextField.text == passwordReenterTextField.text {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }

    private func registerApi() {
        // https://teachapi.herokuapp.com/sign_up
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
                "name": "\(nameTextField.text!)",
                "bio": "a",
                "email": "\(emailTextField.text!)",
                "password": "\(passwordTextField.text!)",
                "password_confirmation": "\(passwordReenterTextField.text!)"
            ]
        ]

        do{
            req.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }catch{
            print(error.localizedDescription)
        }

        print(req)
        let task = session.dataTask(with: req) { (data, response, error) in
            // tokenせーぶしてるコード。これを登録とかログインに書くとどこでもtoken使えるようになる
            do {
                let json: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                UserDefaults.standard.set(json["token"], forKey: "token")
                UserDefaults.standard.synchronize()

            } catch {}
        }
        task.resume()
    }
    
}
