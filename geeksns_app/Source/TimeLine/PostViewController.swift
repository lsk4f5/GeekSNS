//
//  PostViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {

    var post: [[String: Any]]?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        postApi()
    }

    func postApi() {
        // https://teachapi.herokuapp.com/posts
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
                // なぜ変数kasuにjsonを入れているのでしょうか？他の関数の中でもjsonを使いたいからですよ。
                self.post = json
                // 強制的にメインスレッドにするためのコードです。メインスレッドとバックスレッドがあります。UIの更新はメインスレッドのみです。通信はバックれスレッドで行われているので、このタイミングはちょうどバックスレッドからメインいに変わるかどうかの境目のタイミンぐだから、念のためにメインスレッドにして、self.tableView.reloadDataを実行しています
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {}
            // ここでJSONSeriarizationやる
        }
        task.resume()
    }

}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! PostCell

        if let kasu = post {
            postCell.kassLabel.text = kasu[indexPath.row]["text"] as? String
            postCell.postimg.image = UIImage(named: "01")
            postCell.kassName.text =  (kasu[indexPath.row]["user"] as? [String: Any])?["name"] as? String
        }
        return postCell
    }

}
