//
//  ViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var touroku: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBAction func top_button(_ sender: Any) {
    }
    @IBAction func login_button(_ sender: Any){
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        login.layer.cornerRadius = 23;
        touroku.layer.cornerRadius = 23;
        // Do any additional setup after loading the view.
    }
}

