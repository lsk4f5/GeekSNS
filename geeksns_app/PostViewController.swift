//
//  PostViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class PostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var kasu: [[String: Any]]?
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 25
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let kassCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! KassCell
       
    if let kasu = kasu {
        kassCell.kassLabel.text = kasu[indexPath.row]["text"] as? String
        kassCell.postimg.image = UIImage(named: "01")
        kassCell.kassName.text =  (kasu[indexPath.row]["user"] as? [String: Any])?["name"] as? String
        
        //  以下のコードが各まるだよ
//        kassCell.postimg.clipsToBounds = true
//        kassCell.postimg.layer.cornerRadius = 50
            
    }
        return kassCell
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
            self.navigationItem.hidesBackButton = true
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
                     
            
            // 1. doとは。do-catch構文とは。多分、詳細Swiftに書いてある。一言で説明すると、失敗する可能性のある処理をdo-catch構文を使うことが多いです。で、doの中でに失敗する可能性のあるコードを書きます。成功したら問題なし。失敗したら　catchの中が実行されます。catchの中には失敗したらどうするか。エラーハンドリングのコードを書くんだよ。で、この場合で言うとまず、tryってあるじゃないですか。これ失敗する可能性があります。
            do {
                 let json: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                
                //なぜ変数kasuにjsonを入れているのでしょうか？他の関数の中でもjsonを使いたいからですよ。
                self.kasu = json
               
                //強制的にメインスレッドにするためのコードです。メインスレッドとバックスレッドがあります。UIの更新はメインスレッドのみです。で。、通信はバックれスレッドで行われているので、このタイミングはちょうどバックスレッドからメインいに変わるかどうかの境目のタイミンぐだから、念のため確実にメインスレッドにして、self.tableView.reloadDataをy実行しています
                DispatchQueue.main.async {
                     self.tableView.reloadData()
                }
               
            } catch {
                
            }
           
            
            // ここでJSONSeriarizationやるじゃん
            // その後、tableView
            
            //ReactNativeはjavascriptでiOS,Androidアプリ作れます。仕組みは　javascriptのコードをObjective-CとJavaに変換している。が、ReactNativeはできる人は少ないから採用している会社も少ない。
            
            // Objective-Cは20年前に誕生しました。主に、Macアプリを作るために誕生しました。で、10年前iPhoneがでた時も当然最初はObjective-Cでしたが、文法が特有で初心者にとっては難しい、ですごい文句がたくさん出てて、で、Appleが2014年にSwiftを開発しリリースしました。
                  }
            task.resume()
    }
    
    
}
