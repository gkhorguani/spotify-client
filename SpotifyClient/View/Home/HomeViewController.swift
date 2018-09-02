//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, LayoutProvider, SideMenuable {
    var homeView: HomeView! { return self.view as! HomeView }
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    var homePageVM: HomePageViewModel? {
        willSet {
            homePageVM?.viewDelegate = nil
        }
        didSet {
            homePageVM?.viewDelegate = self
        }
    }
    
    private let cellid = "cellid"
    
    override func loadView() {
        view = HomeView(frame: UIScreen.main.bounds)
        homeView.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavBar(title: "Home")
        
        homePageVM = HomePageViewModel()
        
        homeView.featuredPlaylistsCollectionView.dataSource = self
        homeView.featuredPlaylistsCollectionView.delegate = self
        homeView.featuredPlaylistsCollectionView.register(FeaturedPlaylistsCell.self, forCellWithReuseIdentifier: cellid)

        homePageVM?.getFeaturedPlaylists()
        
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
        return homePageVM?.featuredPlaylsits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeView.featuredPlaylistsCollectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! FeaturedPlaylistsCell
        let featuredPlaylist = homePageVM?.featuredPlaylsits[indexPath.row]
        cell.cellVM = FeaturedPlaylistCellViewModel(name: featuredPlaylist?.name, imageURL: featuredPlaylist?.imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}

extension HomeViewController: HomePageViewModelDelegate {
    func featuredPlaylistsFetched() {
        homeView.featuredPlaylistsCollectionView.reloadData()
    }
    
}
