//
//  MypageViewController.swift
//  geeksns_app
//
//  Created by 逢坂美芹 on 2020/03/04.
//  Copyright © 2020 逢坂美芹. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController {
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController!.navigationBar.shadowImage = UIImage()
    
    self.navigationItem.hidesBackButton = true
    }}
