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
    private let releaseCellId = "releasecellid"
    
    override func loadView() {
        view = HomeView(frame: UIScreen.main.bounds)
        homeView.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavBar(title: "Home")
        
        // This might be refactored
        // Coordinator start method should cover this
        homePageVM = HomePageViewModel()
        homeCoordinator = HomeCoordinator(navigationController)
        
        homeView.featuredPlaylistsCollectionView.dataSource = self
        homeView.featuredPlaylistsCollectionView.delegate = self
        homeView.featuredPlaylistsCollectionView.register(FeaturedPlaylistsCell.self, forCellWithReuseIdentifier: cellid)
        
        homeView.latestReleasesTableView.dataSource = self
        homeView.latestReleasesTableView.delegate = self
        homeView.latestReleasesTableView.register(LatestReleaseCell.self, forCellReuseIdentifier: releaseCellId)
        homeView.latestReleasesTableView.rowHeight = UITableViewAutomaticDimension
        
        homePageVM?.getFeaturedPlaylists()
        homePageVM?.getNewReleases()
    }
    
    func setupUI() {
        self.setupLayout()
    }
    
    @IBAction func onMenuTapped() {
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
        cell.cellVM = FeaturedPlaylistCellViewModel(uri: (featuredPlaylist?.uri)!, name: featuredPlaylist?.name, imageURL: featuredPlaylist?.imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 10, 20)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePageVM?.newReleases.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeView.latestReleasesTableView.dequeueReusableCell(withIdentifier: releaseCellId) as! LatestReleaseCell
        let releaseItem = homePageVM?.newReleases[indexPath.row]
        cell.selectionStyle = .none
        cell.cellVM = LatestReleaseCellViewModel(name: releaseItem?.name, imageURL: releaseItem?.imageUrl)
        
        return cell
    }
    
    
}

extension HomeViewController: HomePageViewModelDelegate {
    func featuredPlaylistsFetched() {
        homeView.featuredPlaylistsCollectionView.reloadData()
    }
    
    func newReleasesFetched() {
        homeView.latestReleasesTableView.reloadData()
    }
}
