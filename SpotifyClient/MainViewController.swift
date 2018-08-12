//
//  MainViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var player: SPTAudioStreamingController?
    var spotifyAuthUtils: SpotifyAuthUtils?
    
    var isOpen = false
    var navigationStack: UINavigationController?
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    
    fileprivate func createPlayer<T>(delegate: T) {
        spotifyAuthUtils = SpotifyAuthUtils()
        
        if let authToken = spotifyAuthUtils?.readAuthToken() {
            if self.player == nil {
                self.player = SPTAudioStreamingController.sharedInstance()
                self.player!.playbackDelegate = delegate as! SPTAudioStreamingPlaybackDelegate
                self.player!.delegate = delegate as! SPTAudioStreamingDelegate
                try! player!.start(withClientId: spotifyAuthUtils?.auth?.clientID)
                self.player!.login(withAccessToken: authToken.accessToken)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showSideMenu() {
        menuLeftConstraint.constant = isOpen ? -240 : 0
        isOpen = !isOpen
    }
    
    func hideSideMenu() {
        menuLeftConstraint.constant = -240
        isOpen = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
                
                createPlayer(delegate: playerVC)
                
                playerVC.player = self.player
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
        playlistsCoordinator.start(withPlayer: self.player)
    }
}
