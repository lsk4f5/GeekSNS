//
//  CreateViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/10.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    

    @IBAction func cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var post_field: UITextView!
    @IBAction func post_button(_ sender: Any) {
        //        https://teachapi.herokuapp.com/posts
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/posts"
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        
        req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        /*
         では解説をしていきます。要は。
         {
             post_params: {
                   text: "テキストの内容"
             }
         }
         これをreq.httpBodyに送れれば良い。
         これはSwift的には2重の辞書なんだと言うことをまず理解する必要があります。
         {
             post_params: {
                   text: "テキストの内容"
             }
         }
         は、2重の辞書です。post_paramsというキーに対して、
         {
               text: "テキストの内容"
         }
         という値が入っており、またこれはtextというキーの中に"テキストの内容"という値が入っているためこれは2重の辞書
         それを、
         var postParameter = [String: Any]()
         var param = [String: Any]()
         param["text"] = "aaaaaaa"
         postParameter["post_params"] = param
         で表現をしています。
         
         まず2重の辞書を作って、その辞書をJSONSerializationを使って辞書からDataに変換し
         req.httpBodyに入れています。
         req.httpBody = try! JSONSerialization.data(withJSONObject: postParameter, options: .fragmentsAllowed)
         です
         */
        var postParameter = [String: Any]()
        var param = [String: Any]()
        param["text"] = post_field.text
        postParameter["post_params"] = param
        
        req.httpBody = try! JSONSerialization.data(withJSONObject: postParameter, options: .fragmentsAllowed)
        
        let task = session.dataTask(with: req) { (data, response, error) in
            
            do {
                let json: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print(json)
                
                
            } catch {
                
            }
            
        }
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.popViewController(animated: true)
    }
}
    

