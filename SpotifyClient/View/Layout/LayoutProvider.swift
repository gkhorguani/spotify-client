//
//  LayoutViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/29/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol LayoutProvider {
    
}

extension LayoutProvider where Self: UIViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor(red:0.10, green:0.11, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.10, green:0.11, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
    }
}


