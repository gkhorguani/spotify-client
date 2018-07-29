//
//  MenuViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, MenuRoutable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    weak var menuRouteDelegate: MenuRouteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        sideMenuDelegate = parent as? SideMenuViewDelegate
    }
    
    @IBAction func goToPlaylists() {
        menuRouteDelegate?.goToPlaylists()
    }

}
