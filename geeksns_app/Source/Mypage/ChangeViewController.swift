//
//  ChangeViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/11.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

final class ChangeViewController: UIViewController {

    @IBOutlet weak var nameChange: UITextField!
    @IBOutlet weak var bioChange: UITextField!
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func changeButton(_ sender: Any) {
        changeApi()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func changeApi() {
        // https://teachapi.herokuapp.com/users/{id}
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

        // トークン使ってる
        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        var userParameter = [String: Any]()
        var param = [String: Any]()
        param["name"] = nameChange.text
        param["bio"] = bioChange.text
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

}
