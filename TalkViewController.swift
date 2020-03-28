//
//  TalkViewController.swift
//  geeksns_app
//
//  Created by osakamiseri on 2020/03/29.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class TalkViewController: UIViewController {
    
    
    @IBAction func back_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
}
