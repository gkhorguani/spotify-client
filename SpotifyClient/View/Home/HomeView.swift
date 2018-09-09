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
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        
        return sv
    }()

    lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "header_texture")
        iv.contentMode = .scaleToFill

        return iv
    }()

    lazy var featuredPlaylistsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 275), collectionViewLayout: layout)

        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false

        return cv
    }()

    lazy var latestArtistsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Latest artist"
        label.font = UIFont(name: label.font.fontName, size: 50)
        
        return label
    }()

    lazy var scrollViewBottomAnchor: UILabel = {
        let label = UILabel()
        return label
    }()

    // MARK: - Render
    func render() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.size.equalTo(self)
        }

        scrollView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.width.equalTo(scrollView)
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
        scrollView.addSubview(searchTextBox)

        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
        }

        searchTextBox.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.equalTo(headerImageView).offset(90)
            make.width.equalTo(self.safeAreaLayoutGuide).offset(-50)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }

        scrollView.addSubview(featuredPlaylistsCollectionView)
        featuredPlaylistsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchTextBox.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(275)
        }

        scrollView.addSubview(latestArtistsLabel)
        latestArtistsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(featuredPlaylistsCollectionView.snp.bottom).inset(-100)
            make.leading.trailing.equalTo(scrollView)
        }
        
        // SOMETHING SHOULD BE LINKED TO THE BOTTOM OF THE SCROLLVIEW
        // This should always be linked to bottom of the scrolleview and top to the last element
        scrollView.addSubview(scrollViewBottomAnchor)
        scrollViewBottomAnchor.snp.makeConstraints { (make) in
            make.top.equalTo(latestArtistsLabel.snp.bottom).inset(-1000)
            make.bottom.equalTo(scrollView)
        }
    }
}

