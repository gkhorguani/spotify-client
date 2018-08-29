//
//  LayoutViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/29/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol LayoutProvider {
    func setupLayout()
    func setNavBarTransparency()
    func setNavBar(title: String)
}

extension LayoutProvider where Self: UIViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor(red:0.10, green:0.11, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.10, green:0.11, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        setNavBarTransparency()
    }
    
    func setNavBarTransparency() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setNavBar(title: String) {
        navigationItem.title = title
    }
}


