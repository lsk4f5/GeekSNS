//
//  CustomView.swift
//  geeksns_app
//
//  Created by osakamiseri on 2020/03/27.
//  Copyright © 2020 逢坂美芹. All rights reserved.

import  UIKit

class CustomView: UITextField {

    override func layoutSubviews() {
        self.borderStyle = .none
        self.layer.cornerRadius = 15
        self.layer.borderWidth  = 0.5
        self.layer.masksToBounds = true
    }

}
