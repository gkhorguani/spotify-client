//
//  HomeView.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 9/1/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    // MARK: - UI Elements
    lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "header_texture")
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    lazy var featuredPlaylistsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 100), collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    // MARK: - Render
    func render() {
        addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(150)
        }
        
        let searchButton = UIButton()
        searchButton.setTitle("Go", for: .normal)
        searchButton.setTitleColor(.blue, for: .normal)
        searchButton.layer.cornerRadius = 25
        
        let searchTextBox = UITextField()
        searchTextBox.placeholder = "Search anything.."
        searchTextBox.backgroundColor = .white
        searchTextBox.layer.cornerRadius = 25
        searchTextBox.setLeftPaddingPoints(20)
        searchTextBox.rightView = searchButton
        searchTextBox.rightViewMode = .always
        addSubview(searchTextBox)
        
        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
        }
        
        searchTextBox.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.equalTo(self).offset(50)
            make.trailing.equalTo(self).offset(-50)
            make.top.equalTo(self).offset(90)
            make.centerX.equalTo(self)
        }
        
        addSubview(featuredPlaylistsCollectionView)
        featuredPlaylistsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchTextBox.snp.bottom).offset(50)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(150)
        }
    }
}
