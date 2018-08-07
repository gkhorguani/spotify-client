//
//  MainViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var isOpen = false
    var navigationStack: UINavigationController?
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    
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
            
        }
    }

}

extension MainViewController: SideMenuViewDelegate {  
    func toggleSideMenu() {
        showSideMenu()
    }
}

extension MainViewController: MenuRouteDelegate {
    func goToPlaylists() {
        self.toggleSideMenu()
        
        let playlistsCoordinator = PlaylistsCoordinator(self.navigationStack)
        playlistsCoordinator.start(nil)
    }
}
