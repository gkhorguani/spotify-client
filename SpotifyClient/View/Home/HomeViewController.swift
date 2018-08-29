//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, LayoutProvider, SideMenuable, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    var homePageVM = HomePageViewModel()
    
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
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100), collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavBar(title: "Home")
        render()
        
        homePageVM.getFeaturedPlaylists {
            print("Feched the playlists..")
        }
        
    }
    
    func setupUI() {
        self.setupLayout()
        
        featuredPlaylistsCollectionView.dataSource = self
        featuredPlaylistsCollectionView.delegate = self
        featuredPlaylistsCollectionView.register(FeaturedPlaylistsCell.self, forCellWithReuseIdentifier: cellid)
    }
    
    @IBAction func onMenuTapped() {
        print("Menu tapped")
        sideMenuDelegate?.toggleSideMenu()
    }
    
    func getNavigationStack() -> UINavigationController? {
        return navigationController
    }
    
    // MARK: - Render
    func render() {
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
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
        view.addSubview(searchTextBox)
        
        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
        }
        
        searchTextBox.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.top.equalTo(view).offset(50)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(featuredPlaylistsCollectionView)
        featuredPlaylistsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerImageView.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(150)
        }
    }
    
    // MARK: - Featured playlists collection view
    private let cellid = "cellid"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return featuredPlaylistsCollectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! FeaturedPlaylistsCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}
