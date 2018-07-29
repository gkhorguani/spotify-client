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
    
    init(_ navController: UINavigationController?) {
        self.navigationController = navController
    }
    
    func start(_ router: Router<String>?) {
        // ...
        let playlistsVC = PlaylistsViewController()
        
        self.navigationController?.pushViewController(playlistsVC, animated: false)
    }
}
