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
        //外枠の色を指定
        self.login.layer.borderColor = UIColor.systemGreen.cgColor
        //外枠の太さを指定
        self.login.layer.borderWidth = 1
        login.layer.cornerRadius = 23;
        touroku.layer.cornerRadius = 23;
    }
}

