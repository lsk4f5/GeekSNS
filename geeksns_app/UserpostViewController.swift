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
    @IBOutlet weak var tableView: UITableView!
    func tableView(
      _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
      return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        follow_button.layer.cornerRadius = 15;
        tableView.delegate = self
        tableView.dataSource = self
    }
}
