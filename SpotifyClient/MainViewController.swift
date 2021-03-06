//
//  MainViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var spotifyAuthUtils: SpotifyAuthUtils?
    
    var isOpen = false
    var navigationStack: UINavigationController?
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuLeftConstraint.constant = self.isOpen ? -240 : 0
            self.view.layoutIfNeeded()
            self.isOpen = !self.isOpen
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "appSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController
            
            if targetController is SideMenuable {
                var targetCasted = targetController as! SideMenuable
                targetCasted.sideMenuDelegate = self
                
                navigationStack = targetCasted.getNavigationStack()
            }
        }
        
        if segue.identifier == "menuSegue" {
            let targetController = segue.destination
            if targetController is MenuRoutable {
                var targetCasted = targetController as! MenuRoutable
                targetCasted.menuRouteDelegate = self
            }
        }
        
        if segue.identifier == "playerSegue" {
            let targetController = segue.destination
            if targetController is PlaybackViewController {
                let playerVC = targetController as! PlaybackViewController
                
                PlayerSingleton.sharedInstance.player?.delegate = playerVC
                PlayerSingleton.sharedInstance.player?.playbackDelegate = playerVC
            }
        }
    }

}

// MARK: - Side Menu delegate methods
extension MainViewController: SideMenuViewDelegate {  
    func toggleSideMenu() {
        showSideMenu()
    }
}

// MARK: - Router from side menu delegate methods
extension MainViewController: MenuRouteDelegate {
    func goToPlaylists() {
        self.toggleSideMenu()
        
        let playlistsCoordinator = PlaylistsCoordinator(self.navigationStack, menuDelegate: self)
        playlistsCoordinator.start(nil)
    }
}
