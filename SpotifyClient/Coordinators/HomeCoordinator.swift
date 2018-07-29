//
//  HomeCoordinator.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol HomeCoordinatorViewDelegate {
    func showPlaylist(playlistId: String)
}

class HomeCoordinator: Coordinator {
    let navigationControoler: UINavigationController?
    
    init(_ navController: UINavigationController?) {
        self.navigationControoler = navController
    }
    
    func start(_ router: Router<String>?) {
        // This is an entry point
    }
}

extension HomeCoordinator: HomeCoordinatorViewDelegate {
    func showPlaylist(playlistId: String) {
        let playlistsCoordinator = PlaylistsCoordinator(self.navigationControoler)
        let router = Router<String>()
        router.setParmeters(playlistId)
        
        playlistsCoordinator.start(router)
    }
}
