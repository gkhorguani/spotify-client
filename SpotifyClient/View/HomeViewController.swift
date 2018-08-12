//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, LayoutProvider, SideMenuable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    var homePageVM = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
