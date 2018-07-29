//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SideMenuable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    @IBOutlet weak var showPlaylists: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Home vc..")
        
        setupInjections()
    }
    
    func setupInjections() {
        homeCoordinator = HomeCoordinator(self.navigationController)
    }
    
    @IBAction func showPlaylists(_ sender: Any) {
        homeCoordinator?.showPlaylist(playlistId: "somePlaylistId")
    }
    
    @IBAction func onMenuTapped() {
        print("Menu tapped")
        sideMenuDelegate?.toggleSideMenu()
    }
    
}
