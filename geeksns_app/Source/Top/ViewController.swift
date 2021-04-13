//
//  ViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = 23
        }
    }
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.borderColor = UIColor.systemGreen.cgColor
            loginButton.layer.borderWidth = 1
            loginButton.layer.cornerRadius = 23
        }
    }
    @IBAction func registerSendButton(_ sender: Any) {

    }
    @IBAction func loginSendButton(_ sender: Any){

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
    }
}

