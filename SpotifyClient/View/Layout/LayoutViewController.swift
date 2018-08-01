//
//  LayoutViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/29/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol LayoutViewController {
    
}

extension LayoutViewController where Self: UIViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor(red:0.08, green:0.09, blue:0.12, alpha:1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.09, blue:0.12, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        let image : UIImage = UIImage(named: "sp_logo-1.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red:0.92, green:0.13, blue:0.33, alpha:1.0)
        
        self.navigationItem.titleView = imageView
    }
}


