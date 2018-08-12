//
//  PlaylistsCoordinator.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlaylistsCoordinator: Coordinator {
    let navigationController: UINavigationController?
    let menuDelegate: SideMenuViewDelegate?
    
    init(_ navController: UINavigationController?, menuDelegate: SideMenuViewDelegate?) {
        self.navigationController = navController
        self.menuDelegate = menuDelegate
    }
    
    func start(_ router: Router<String>?) {
        // ...
        let playlistsVC = PlaylistsViewController()
        
        self.navigationController?.pushViewController(playlistsVC, animated: false)
    }
    
    func start(withPlayer player: SPTAudioStreamingController?) {
        let playlistsVC = PlaylistsViewController()
        playlistsVC.player = player
        
        playlistsVC.sideMenuDelegate = menuDelegate
        
        self.navigationController?.pushViewController(playlistsVC, animated: false)
    }
}
