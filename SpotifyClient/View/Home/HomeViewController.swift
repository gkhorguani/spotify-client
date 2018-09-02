//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, LayoutProvider, SideMenuable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    var homePageVM = HomePageViewModel()
    var homeView: HomeView! { return self.view as! HomeView }
    
    private let cellid = "cellid"
    
    override func loadView() {
        view = HomeView(frame: UIScreen.main.bounds)
        homeView.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavBar(title: "Home")
        
        homeView.featuredPlaylistsCollectionView.dataSource = self
        homeView.featuredPlaylistsCollectionView.delegate = self
        homeView.featuredPlaylistsCollectionView.register(FeaturedPlaylistsCell.self, forCellWithReuseIdentifier: cellid)

        homePageVM.getFeaturedPlaylists {
            print("Feched the playlists..")
        }
        
    }
    
    func setupUI() {
        self.setupLayout()
    }
    
    @IBAction func onMenuTapped() {
        print("Menu tapped")
        sideMenuDelegate?.toggleSideMenu()
    }
    
    func getNavigationStack() -> UINavigationController? {
        return navigationController
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Featured playlists collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return homeView.featuredPlaylistsCollectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! FeaturedPlaylistsCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}
